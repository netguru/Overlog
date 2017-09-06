//
//  FeatureSpec.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Quick
import Nimble
import Overlog

class FeatureSpec: QuickSpec {
    
    override func spec() {
        var dataSource: FeaturesDataSource?
        
        describe("when data source is set") {
            
            beforeEach {
                dataSource = FeaturesDataSource()
            }
            
            afterEach {
                dataSource = nil
            }
            
            context("available features are properly extracted") {
                
                var features: [Feature]?
                
                beforeEach {
                    features = dataSource?.allItems
                }
                
                afterEach {
                    features = nil
                }
                
                it("assures that the array is not nil") {
                    expect(features).toNot(beNil())
                }
                
                it("assumes that there's at least one feature type supported") {
                    expect(features!.count) > 0
                }
                
                it("correctly updates feature counter") {
                    var feature = features!.first!
                    feature.changeCounter(counter: 64)
                    expect(feature.counter) == 64
                }
            }
            
            context("feature types are properly extracted") {
                
                var featureTypes: [FeatureType]?
                
                beforeEach {
                    featureTypes = dataSource?.allItems.map { (value: Feature) -> FeatureType in
                        return value.type
                    }
                }
                
                afterEach {
                    featureTypes = nil
                }
                
                it("assures that the array is not nil") {
                    expect(featureTypes).toNot(beNil())
                }
                
                it("assumes that there's at least one feature type supported") {
                    expect(featureTypes!.count) > 0
                }
                
                it("makes sure that enabled features are extracted properly") {
                    let enabledItems = dataSource?.enabledItems.map { (value: Feature) -> FeatureType in
                        return value.type
                    }
                    let filteredItems = featureTypes!.filter { (feature: FeatureType) -> Bool in
                        return UserDefaults.standard.bool(forKey: feature.defaultsKey)
                    }
                    expect(enabledItems) == filteredItems
                }
            }
            
            context("feature type is set up properly") {
                
                var featureType: FeatureType?
                
                beforeEach {
                    featureType = dataSource?.allItems.map { (value: Feature) -> FeatureType in
                        return value.type
                    }.first
                }
                
                afterEach {
                    featureType = nil
                }
                
                it("assures that feature type is not nil") {
                    expect(featureType).toNot(beNil())
                }
                
                it("properly constructs feature type defaults key") {
                    expect(featureType!.defaultsKey) == "OVL\(featureType!.description)ReferenceKey".replacingOccurrences(of: " ", with: "")
                }
                
            }
        }
    }
}
