//
//  URLConfigurationStorageSpec.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Quick
import Nimble
import Overlog

class URLConfigurationStorageSpec: QuickSpec {
    
    override func spec() {
        var legacyHost: String? = nil
        var legacyScheme: Scheme = .http
        
        beforeSuite {
            legacyHost = URLConfigurationStorage.host
            legacyScheme = URLConfigurationStorage.scheme
        }
        
        afterSuite {
            URLConfigurationStorage.host = legacyHost
            URLConfigurationStorage.scheme = legacyScheme
        }
        
        describe("when changing host") {
            context("to any value") {
                beforeEach {
                    URLConfigurationStorage.host = "foo"
                }
                
                it("host should be properly changed") {
                    expect(URLConfigurationStorage.host).to(equal("foo"))
                }
            }
            context("to nil value") {
                beforeEach {
                    URLConfigurationStorage.host = nil
                }
                
                it("host should be properly changed") {
                    expect(URLConfigurationStorage.host).to(beNil())
                }
            }
        }
        
        describe("when changing scheme") {
            beforeEach {
                URLConfigurationStorage.scheme = .https
            }
            
            it("scheme should be properly changed") {
                expect(URLConfigurationStorage.scheme).to(equal(Scheme.https))
            }
        }
    }
}
