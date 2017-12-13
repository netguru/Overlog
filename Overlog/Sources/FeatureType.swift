//
//  FeatureType.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

/// Feature types to configure Overlog behvavior.
public enum FeatureType: String {
    case network = "HTTP Traffic"
    case keychain = "Keychain"
    case userDefaults = "User Defaults"
    case consoleLogs = "Console Logs"
    case systemLogs = "System Logs"
    case url = "URL Configuration"
    
    /// All available feature types.
    static public var all: [FeatureType] {
        return [.network, .userDefaults, .keychain, .consoleLogs, .systemLogs, .url]
    }
    
    /// Default feature types.
    static public var `default`: [FeatureType] {
        return [.network, .userDefaults, .keychain, .systemLogs]
    }
    
    /// User defaults key for corresponding feature type.
    internal var referenceKey: String {
        return "OVL\(rawValue)ReferenceKey".replacingOccurrences(of: " ", with: "")
    }

    /// An icon of feature type.
    internal var icon: String {
        switch self {
        case .network:
            return "\u{1F30D}"
        case .consoleLogs:
            return "\u{1F916}"
        case .keychain:
            return "\u{1F510}"
        default:
            return ""
        }
    }
}
