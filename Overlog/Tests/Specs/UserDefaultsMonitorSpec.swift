//
//  UserDefaultsMonitorSpec.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Quick
import Nimble
@testable import Overlog

class UserDefaultsMonitorSpec: QuickSpec {
    
    // MARK: Mocks
    
    class MockUserDefaultsMonitorDataSource: UserDefaultsMonitorDataSource {
        let mockDictionaryRepresentation: [String: Any]
        
        init(dictionaryRepresentation: [String: Any]) {
            mockDictionaryRepresentation = dictionaryRepresentation
        }
        
        func dictionaryRepresentation() -> [String: Any] {
            return mockDictionaryRepresentation
        }
    }
    
    class MockUserDefaultsMonitorDelegate: UserDefaultsMonitorDelegate {
        private(set) var items: [UserDefaultsItem]?
        private(set) var informed = false
        
        func monitor(_ monitor: UserDefaultsMonitor, didGet items: [UserDefaultsItem]) {
            informed = true
            self.items = items
        }
    }
    
    // MARK: Specs
    
    override func spec() {
        var sut: UserDefaultsMonitor!
        var delegate: MockUserDefaultsMonitorDelegate!
        
        beforeEach {
            delegate = MockUserDefaultsMonitorDelegate()
        }
        
        afterEach {
            sut = nil
            delegate = nil
        }
        
        describe("when user defaults does not contain items") {
            
            beforeEach {
                sut = UserDefaultsMonitor(dataSource: MockUserDefaultsMonitorDataSource(dictionaryRepresentation: [:]))
                sut.delegate = delegate
                sut.subscribeForItems()
            }
            
            it("items subscription should return 0 items") {
                expect(delegate.items).toNot(beNil())
                expect(delegate.items!.count).to(equal(0))
            }
            
            it("items subscription should inform delegate about items") {
                expect(delegate.informed).to(beTruthy())
            }
        }
        
        describe("when user defaults contains items") {
            
            beforeEach {
                let dictionary = ["key.1" : "fixture.value.1", "key.2" : "fixture.value.2"]
                sut = UserDefaultsMonitor(dataSource: MockUserDefaultsMonitorDataSource(dictionaryRepresentation: dictionary))
                sut.delegate = delegate
                sut.subscribeForItems()
            }
            
            it("items subscription should return 2 items") {
                expect(delegate.items).toNot(beNil())
                expect(delegate.items!.count).to(equal(2))
            }
            
            it("returned items should be sorted alphabetically ascending") {
                expect(delegate.items![0].key).to(equal("key.1"))
                expect(delegate.items![0].value).to(equal("fixture.value.1"))
                expect(delegate.items![1].key).to(equal("key.2"))
                expect(delegate.items![1].value).to(equal("fixture.value.2"))
            }
            
            it("items subscription should inform delegate about items") {
                expect(delegate.informed).to(beTruthy())
            }
        }
    }
}
