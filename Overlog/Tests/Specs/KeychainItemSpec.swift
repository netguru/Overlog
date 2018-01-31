//
//  KeychainItemSpec.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Quick
import Nimble
@testable import Overlog

class KeychainItemSpec: QuickSpec {
    
    override func spec() {
        var sut: KeychainItem!
        
        afterEach {
            sut = nil;
        }
        
        describe("when initializing") {
            context("with wrong dictionary") {
                beforeEach {
                    sut = KeychainItem(raw: ["foo" : "bar"])
                }
                
                it("key should not have key") {
                    expect(sut.key).to(equal("no key"))
                }
                
                it("key should not have value") {
                    expect(sut.value).to(equal("no value"))
                }
            }
            
            context("with dictionary containing key") {
                beforeEach {
                    sut = KeychainItem(raw: ["key" : "fixture.key"])
                }
                
                it("key should have key") {
                    expect(sut.key).to(equal("fixture.key"))
                }
                
                it("key should not have value") {
                    expect(sut.value).to(equal("no value"))
                }
            }
            
            context("with dictionary containing value") {
                beforeEach {
                    sut = KeychainItem(raw: ["value" : "fixture.value"])
                }
                
                it("key should not have key") {
                    expect(sut.key).to(equal("no key"))
                }
                
                it("key should not have value") {
                    expect(sut.value).to(equal("fixture.value"))
                }
            }
            
            context("with dictionary containing key and value") {
                beforeEach {
                    sut = KeychainItem(raw: ["key" : "fixture.key", "value" : "fixture.value"])
                }
                
                it("key should not have key") {
                    expect(sut.key).to(equal("fixture.key"))
                }
                
                it("key should not have value") {
                    expect(sut.value).to(equal("fixture.value"))
                }
            }
        }
    }
}
