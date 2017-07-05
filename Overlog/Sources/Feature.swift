//
//  Feature.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

/// All overlog feature types
internal enum FeatureType: String {
    case network, userDefaults

    var description: String {

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

    /// Feature type
    let type: FeatureType

    /// Feature counter used for notifications
    var counter: Int
}
