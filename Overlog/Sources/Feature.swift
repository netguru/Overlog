//
//  Feature.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

/// All overlog feature types
internal enum FeatureType: String {
    case network, keychain, userDefaults, consoleLogs, systemLogs

    var description: String {

        switch self {
            case .userDefaults:
                return "User Defaults"
            case .keychain:
                return "Keychain"
            case .network:
                return "HTTP"
            case .consoleLogs:
                return "Console Logs"
            case .systemLogs:
                return "System Logs"
        }
    }
    
    var defaultsKey: String {
        return "OVL\(description)ReferenceKey".replacingOccurrences(of: " ", with: "")
    }
}

/// Overlog feature model
internal struct Feature {
    
    /// Name for notification informing about changes in enabled features data source
    static let enabledFeaturesDidChangeNotificationKey = Notification.Name(rawValue: "OVLEnabledFeaturesDidChange")

    /// Feature type
    let type: FeatureType

    /// Feature counter used for notifications
    var counter: Int

    mutating func changeCounter(counter: Int) {
        self.counter = counter
    }
}
