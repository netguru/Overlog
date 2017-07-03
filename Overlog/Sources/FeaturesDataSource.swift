//
//  FeaturesDataSource.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

// Struct that keeps all possible options in
internal struct FeaturesDataSource {

    /// Data source items
    internal var items: [Feature] = []

    /// Initialize the receiver
    internal init() {
        items = prepareItems()
    }

    fileprivate func prepareItems() -> [Feature] {
        return [
            Feature(type: .userDefaults, counter:0),
            Feature(type: .network, counter: 0)
        ]
    }
}
