//
//  Overseer.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
import Overlog
import ResponseDetective

class OverseerSpec: QuickSpec {
    
    override func spec() {
        var overseer: Overseer!
        
        describe("when new request was sended") {
            
            var urlStub: OHHTTPStubsDescriptor!
            let fixedHost = "fixedhost.com"
            let url = URL(string: "http://\(fixedHost)/fixed/path")!
            var session: URLSession!
            let configuration = URLSessionConfiguration.default
            
            beforeEach {
                overseer = Overseer()
                overseer.watch(on: configuration)
                session = URLSession(configuration: configuration)
                
            }
            
            afterEach {
                OHHTTPStubs.removeStub(urlStub)
                overseer = nil
                urlStub = nil
                session = nil
                
            }
            context("will notify about a new") {
                
                var delegate: OverseerDelegateMock!
                
                beforeEach {
                    delegate = OverseerDelegateMock()
                    overseer.delegate = delegate
                }
                
                afterEach {
                    delegate = nil
                }
                
                it("request") {
                    expect(overseer).toNot(beNil())
                    
                    urlStub = stub(condition: isHost(fixedHost), response: { _ in
                        let stubData = "fixed.response".data(using: .utf8)
                        return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
                    })
                    
                    let exp = self.expectation(description: "expect to be notified about a new request")
                    session.dataTask(with: url, completionHandler: { data, response, error in
                        exp.fulfill()
                    })
                    .resume()
                    self.waitForExpectations(timeout: 1, handler: nil)
                    
                    expect((overseer.delegate as! OverseerDelegateMock).requestCounter).toEventually(equal(1))
                }
                
                it("response") {
                    expect(overseer).toNot(beNil())
                    
                    urlStub = stub(condition: isHost(fixedHost), response: { _ in
                        let stubData = "fixed.response".data(using: .utf8)
                        return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
                    })
                    
                    let exp = self.expectation(description: "expect to be notified about a new response")
                    session.dataTask(with: url, completionHandler: { data, response, error in
                        exp.fulfill()
                    })
                    .resume()
                    self.waitForExpectations(timeout: 1, handler: nil)
                    
                    expect((overseer.delegate as! OverseerDelegateMock).responseCounter).toEventually(equal(1))
                }
                
                it("error") {
                    expect(overseer).toNot(beNil())
                    
                    urlStub = stub(condition: isHost(fixedHost), response: { _ in
                        return OHHTTPStubsResponse(error: OverseerErrorMock.fixedError)
                    })
                    
                    let exp = self.expectation(description: "expect to be notified about a new error")
                    session.dataTask(with: url, completionHandler: { data, response, error in
                        exp.fulfill()
                    })
                    .resume()
                    self.waitForExpectations(timeout: 1, handler: nil)
                    
                    expect((overseer.delegate as! OverseerDelegateMock).errorCounter).toEventually(equal(1))
                }
            }
            
            context("will catch a new") {
                it("request") {
                    expect(overseer).toNot(beNil())
                    
                    urlStub = stub(condition: isHost(fixedHost), response: { _ in
                        let stubData = "fixed.response".data(using: .utf8)
                        return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
                    })
                    
                    let exp = self.expectation(description: "expect to catch a request")
                    session.dataTask(with: url, completionHandler: { data, response, error in
                        exp.fulfill()
                    })
                    .resume()
                    self.waitForExpectations(timeout: 1, handler: nil)
                    
                    expect(overseer.requestRepresentations).toEventually(haveCount(1))
                }
                
                it("response") {
                    expect(overseer).toNot(beNil())
                    
                    urlStub = stub(condition: isHost(fixedHost), response: { _ in
                        let stubData = "fixed.response".data(using: .utf8)
                        return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
                    })
                    
                    let exp = self.expectation(description: "expect to catch a response")
                    session.dataTask(with: url, completionHandler: { data, response, error in
                        exp.fulfill()
                    })
                        .resume()
                    self.waitForExpectations(timeout: 1, handler: nil)
                    
                    expect(overseer.responseRepresentations).toEventually(haveCount(1))
                }
                
                it("error") {
                    expect(overseer).toNot(beNil())
                    
                    urlStub = stub(condition: isHost(fixedHost), response: { _ in
                        return OHHTTPStubsResponse(error: OverseerErrorMock.fixedError)
                    })
                    
                    let exp = self.expectation(description: "expect to catch an error")
                    session.dataTask(with: url, completionHandler: { data, response, error in
                        exp.fulfill()
                    })
                        .resume()
                    self.waitForExpectations(timeout: 1, handler: nil)
                    
                    expect(overseer.errorRepresentations).toEventually(haveCount(1))
                }
            }
            
        }
    }
}

final class OverseerDelegateMock: OverseerDelegate {
    var responseCounter = 0
    var requestCounter = 0
    var errorCounter = 0
    
    func overseer(overseer: Overseer?, didGet response: ResponseRepresentation){
        responseCounter = responseCounter + 1
    }
    func overseer(overseer: Overseer?, didGet request: RequestRepresentation){
        requestCounter = requestCounter + 1
    }
    func overseer(overseer: Overseer?, didGet error: ErrorRepresentation){
        errorCounter = errorCounter + 1
    }
}

enum OverseerErrorMock: Error {
    case fixedError
}
