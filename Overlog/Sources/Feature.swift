//
//  Feature.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

/// All overlog feature types
internal enum FeatureType: String {
    case network, userDefaults, consoleLogs, systemLogs

    var description: String {

        switch self {
            case .userDefaults:
                return "User Defaults"
            case .network:
                return "HTTP"
            case .consoleLogs:
                return "Console Logs"
            case .systemLogs:
                return "System Logs"
        }
    }
}

/// Overlog feature model
internal struct Feature {
    let type: FeatureType
    var counter: Int
}
