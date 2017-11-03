//
//  NetworkMonitorSpec.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Quick
import Nimble
import OHHTTPStubs
import Overlog
import ResponseDetective

class NetworkMonitorSpec: QuickSpec {
    
    override func spec() {
        var monitor: NetworkMonitor!
        
        describe("when new request was sent") {
            
            var urlStub: OHHTTPStubsDescriptor!
            let fixedHost = "fixedhost.com"
            let url = URL(string: "http://\(fixedHost)/fixed/path")!
            var session: URLSession!
            let configuration = URLSessionConfiguration.default
            
            beforeEach {
                monitor = NetworkMonitor.shared
                monitor.watch(on: configuration)
                session = URLSession(configuration: configuration)
                
            }
            
            afterEach {
                OHHTTPStubs.removeStub(urlStub)
                monitor = nil
                urlStub = nil
                session = nil
                
            }
            context("will notify about a new") {
                
                var delegate: NetworkMonitorDelegateMock!
                
                beforeEach {
                    delegate = NetworkMonitorDelegateMock()
                    monitor.delegate = delegate
                }
                
                afterEach {
                    delegate = nil
                }
                
                it("request") {
                    expect(monitor).toNot(beNil())
                    
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
                    
                    expect((monitor.delegate as! NetworkMonitorDelegateMock).requestCounter).toEventually(equal(1))
                }
                
                it("response") {
                    expect(monitor).toNot(beNil())
                    
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
                    
                    expect((monitor.delegate as! NetworkMonitorDelegateMock).responseCounter).toEventually(equal(1))
                }
                
                it("error") {
                    expect(monitor).toNot(beNil())
                    
                    urlStub = stub(condition: isHost(fixedHost), response: { _ in
                        return OHHTTPStubsResponse(error: NetworkMonitorErrorMock.fixedError)
                    })
                    
                    let exp = self.expectation(description: "expect to be notified about a new error")
                    session.dataTask(with: url, completionHandler: { data, response, error in
                        exp.fulfill()
                    })
                    .resume()
                    self.waitForExpectations(timeout: 1, handler: nil)
                    
                    expect((monitor.delegate as! NetworkMonitorDelegateMock).errorCounter).toEventually(equal(1))
                }
            }
            
            context("will catch a new") {
                it("request") {
                    expect(monitor).toNot(beNil())
                    
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
                    
                    expect(monitor.requestRepresentations.count).toEventually(beGreaterThanOrEqualTo(1))
                }
                
                it("response") {
                    expect(monitor).toNot(beNil())
                    
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
                    
                    expect(monitor.responseRepresentations.count).toEventually(beGreaterThanOrEqualTo(1))
                }
                
                it("error") {
                    expect(monitor).toNot(beNil())
                    
                    urlStub = stub(condition: isHost(fixedHost), response: { _ in
                        return OHHTTPStubsResponse(error: NetworkMonitorErrorMock.fixedError)
                    })
                    
                    let exp = self.expectation(description: "expect to catch an error")
                    session.dataTask(with: url, completionHandler: { data, response, error in
                        exp.fulfill()
                    })
                        .resume()
                    self.waitForExpectations(timeout: 1, handler: nil)
                    
                    expect(monitor.errorRepresentations.count).toEventually(beGreaterThanOrEqualTo(1))
                }
            }
            
        }
    }
}

final class NetworkMonitorDelegateMock: NetworkMonitorDelegate {

    var responseCounter = 0
    var requestCounter = 0
    var errorCounter = 0
    
    func monitor(_ monitor: NetworkMonitor, didGet response: ResponseRepresentation){
        responseCounter = responseCounter + 1
    }
    func monitor(_ monitor: NetworkMonitor, didGet request: RequestRepresentation){
        requestCounter = requestCounter + 1
    }
    func monitor(_ monitor: NetworkMonitor, didGet error: ErrorRepresentation){
        errorCounter = errorCounter + 1
    }
}

enum NetworkMonitorErrorMock: Error {
    case fixedError
}
