//
//  Feature.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

internal struct Feature {
    internal let type: FeatureType
    internal let enabled: Bool
    internal var description: String {
        return type.rawValue
    }
    
    init(type: FeatureType, enabled: Bool) {
        self.type = type;
        self.enabled = enabled
    }
    
    /// Feature counter used for notifications
    var counter = Int(0)
    
    mutating func changeCounter(counter: Int) {
        self.counter = counter
    }
}
