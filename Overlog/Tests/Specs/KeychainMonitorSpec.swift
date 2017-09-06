//
//  KeychainMonitorSpec.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Quick
import Nimble
import Overlog

class KeychainMonitorSpec: QuickSpec {

    // MARK: Mocks

    class MockKeychainMonitorDataSource: KeychainMonitorDataSource {
        let mockItems: [[String: Any]]

        init(mockItems: [[String: Any]]) {
            self.mockItems = mockItems
        }

        func allItems() -> [[String: Any]] {
            return mockItems
        }
    }

    class MockKeychainMonitorDelegate: KeychainMonitorDelegate {
        private(set) var items: [KeychainItem]?
        private(set) var informed = false

        func monitor(_ monitor: KeychainMonitor, didGet items: [KeychainItem]) {
            informed = true
            self.items = items
        }
    }

    // MARK: Specs

    override func spec() {
        var sut: KeychainMonitor!
        var delegate: MockKeychainMonitorDelegate!
        
        beforeEach {
            delegate = MockKeychainMonitorDelegate()
        }
        
        afterEach {
            sut = nil;
        }
        
        describe("when keychain does not contain items") {
            
            beforeEach {
                sut = KeychainMonitor(dataSource: MockKeychainMonitorDataSource(mockItems: []))
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
        
        describe("when keychain contains items") {
            
            beforeEach {
                let rawItem = ["key" : "fixture.key", "value" : "fixture.value"]
                sut = KeychainMonitor(dataSource: MockKeychainMonitorDataSource(mockItems: [rawItem]))
                sut.delegate = delegate
                sut.subscribeForItems()
            }
            
            it("items subscription should return 0 items") {
                expect(delegate.items).toNot(beNil())
                expect(delegate.items!.count).to(equal(1))
            }
            
            it("items subscription should inform delegate about items") {
                expect(delegate.informed).to(beTruthy())
            }
        }
    }
}
