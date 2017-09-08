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
    
    // MARK: Mocks
    
    
    // MARK: Specs
    
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
                sut.features = [.network]
            }
            
            it("feature type should be properly set") {
                expect(sut.features).to(equal([.network]))
            }
            
            it("network feature should be available") {
                expect(sut.availableFeatures().filter { $0.type == .network }.first).toNot(beNil())
            }
            
            it("feature should be enabled by default") {
                expect(sut.availableFeatures().filter { $0.type == .network }.first!.enabled).to(beTruthy())
            }
            
            it("should be exact 1 available feature") {
                expect(sut.availableFeatures().count).to(equal(1))
            }
            
            it("network feature should be enabeld") {
                expect(sut.enabledFeatures().filter { $0.type == .network }.first).toNot(beNil())
            }
            
            it("should be exact 1 enabled feature") {
                expect(sut.enabledFeatures().count).to(equal(1))
            }
        }
        
        describe("when disabling network feature") {
            beforeEach {
                sut.features = [.network]
                sut.feature(.network, didEnable: false)
            }
            
            it("network feature should be available") {
                expect(sut.availableFeatures().filter { $0.type == .network }.first).toNot(beNil())
            }
            
            it("network feature should be disabled") {
                expect(sut.enabledFeatures().filter { $0.type == .network }.first).to(beNil())
            }
        }
        
        describe("notification should be posted") {
            let notification = Notification(name: Notification.Name(rawValue: "OVLEnabledFeaturesDidChange"), object: nil)
            
            it("when changing feature") {
                expect {
                    sut.features = [.keychain]
                }.to(postNotifications(contain(notification)))
            }
            
            it("when adding feature") {
                expect {
                    return sut.feature(.systemLogs, didEnable: false)
                }.to(postNotifications(contain(notification)))
            }
        }
    }
}
