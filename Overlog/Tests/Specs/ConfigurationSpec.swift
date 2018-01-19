//
//  ConfigurationSpec.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Quick
import Nimble
import Overlog

class ConfigurationSpec: QuickSpec {

    override func spec() {
        var legacyFlags: [String : Bool] = [:]
        let defaults = UserDefaults.standard
        var sut: Configuration!
        
        beforeSuite {
            FeatureType.all.filter {
                return defaults.object(forKey: $0.referenceKey) != nil
            }.forEach {
                legacyFlags[$0.referenceKey] = defaults.bool(forKey: $0.referenceKey)
                defaults.removeObject(forKey: $0.referenceKey)
            }
        }
        
        afterSuite {
            FeatureType.all.forEach {
                defaults.removeObject(forKey: $0.referenceKey)
            }
            legacyFlags.forEach {
                defaults.set($0.value, forKey: $0.key)
            }
        }
        
        beforeEach {
            sut = Configuration()
        }
        
        afterEach {
            sut = nil
            FeatureType.all.forEach {
                defaults.removeObject(forKey: $0.referenceKey)
            }
        }
        
        describe("when setting network feature") {
            beforeEach {
                sut.features = [.httpTraffic]
            }
            
            it("feature type should be properly set") {
                expect(sut.features).to(equal([.httpTraffic]))
            }
            
            it("network feature should be available") {
                expect(sut.availableFeatures().filter { $0.type == .httpTraffic }.first).toNot(beNil())
            }
            
            it("feature should be enabled by default") {
                expect(sut.availableFeatures().filter { $0.type == .httpTraffic }.first!.enabled).to(beTruthy())
            }
            
            it("should be exact 1 available feature") {
                expect(sut.availableFeatures().count).to(equal(1))
            }
            
            it("network feature should be enabeld") {
                expect(sut.enabledFeatures().filter { $0.type == .httpTraffic }.first).toNot(beNil())
            }
            
            it("should be exact 1 enabled feature") {
                expect(sut.enabledFeatures().count).to(equal(1))
            }
            
            it("configuration should contain this feature type") {
                expect(sut.containsFeature(ofType: .httpTraffic)).to(beTruthy())
            }
        }
        
        describe("when disabling feature") {
            var statusChangeSucceded: Bool!
            
            afterEach {
                statusChangeSucceded = nil
            }
            
            context("which exists") {
                beforeEach {
                    sut.features = [.httpTraffic]
                    statusChangeSucceded = sut.feature(.httpTraffic, didEnable: false)
                }
                
                it("network feature should be available") {
                    expect(sut.availableFeatures().filter { $0.type == .httpTraffic }.first).toNot(beNil())
                }
                
                it("network feature should be disabled") {
                    expect(sut.enabledFeatures().filter { $0.type == .httpTraffic }.first).to(beNil())
                }
                
                it("status change should succeded") {
                    expect(statusChangeSucceded).to(beTruthy())
                }
                
                it("configuration should contain disabled feature type") {
                    expect(sut.containsFeature(ofType: .httpTraffic)).to(beTruthy())
                }
            }
            
            context("which does not exist") {
                beforeEach {
                    statusChangeSucceded = sut.feature(.httpTraffic, didEnable: false)
                }
                
                it("feature should not be available") {
                    expect(sut.availableFeatures().filter { $0.type == .httpTraffic }.first).to(beNil())
                }
                
                it("status change should failed") {
                    expect(statusChangeSucceded).to(beFalsy())
                }
                
                it("configuration should not contain feature type") {
                    expect(sut.containsFeature(ofType: .httpTraffic)).to(beFalsy())
                }
            }
        }
        
        describe("when") {
            let notification = Notification(name: Notification.Name(rawValue: "OVLEnabledFeaturesDidChange"), object: nil)
            
            context("adding feature") {
                it("notification should be posted") {
                    expect {
                        sut.features = [.keychain]
                    }.to(postNotifications(contain(notification)))
                }
            }
            
            context("changing existing feature") {
                beforeEach {
                    sut.features = [.logs]
                }
                
                it("notification should be posted") {
                    expect {
                        return sut.feature(.logs, didEnable: false)
                    }.to(postNotifications(contain(notification)))
                }
            }
            
            context("changing non-existing feature") {
                it("notification should not be posted") {
                    expect {
                        return sut.feature(.logs, didEnable: false)
                    }.toNot(postNotifications(contain(notification)))
                }
            }
        }
    }
}
