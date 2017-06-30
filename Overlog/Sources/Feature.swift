//
//  Feature.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

/// All overlog feature types
internal enum FeatureType: String {
    case network, userDefaults

    var name: String {

        switch self {
            case .userDefaults:
                return "User Defaults"
            case .network:
                return "HTTP"
        }
    }
}


/// Overlog feature model
internal struct Feature {
    let type: FeatureType
    let counter: Int
}
