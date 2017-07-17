//
//  FeaturesDataSource.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

// Struct that keeps all possible options in
internal struct FeaturesDataSource {

    /// All data source items
    internal var allItems: [Feature] = []
    
    /// Enabled data source items
    internal var enabledItems: [Feature] {
        return allItems.filter { (feature: Feature) -> Bool in
            return UserDefaults.standard.bool(forKey: feature.type.defaultsKey)
        }
    }

    /// Initialize the receiver
    internal init() {
        allItems = prepareItems()
    }

    fileprivate func prepareItems() -> [Feature] {
        return [
            Feature(type: .userDefaults, counter: 0),
            Feature(type: .network, counter: 0),
            Feature(type: .keychain, counter: 0),
            Feature(type: .consoleLogs, counter: 0),
            Feature(type: .systemLogs, counter: 0)
        ]
    }
}
