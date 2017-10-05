//
//  URLConfigurationStorage.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

internal final class URLConfigurationStorage {
    
    /// Default storage.
    static fileprivate let defaults = UserDefaults.standard
    
    /// Properties of configuration to use in default storage.
    fileprivate enum URLConfigurationProperty: String {
        case host = "Host"
        case scheme = "Scheme"
        
        /// Reference key to use when accessing value for corresponding url configuration property.
        fileprivate var referenceKey: String {
            return "OVL\(rawValue)ReferenceKey".replacingOccurrences(of: " ", with: "")
        }
    }

    /// Host stored by configuration storage. Optional.
    static var host: String? {
        get {
            return defaults.string(forKey: URLConfigurationProperty.host.referenceKey)
        }
        set {
            defaults.set(newValue, forKey: URLConfigurationProperty.host.referenceKey)
        }
    }
    
    /// Scheme stored by configuration storage. Default: .http.
    static var scheme: Scheme {
        get {
            let defaultValue = Scheme.http
            if let rawValue = defaults.string(forKey: URLConfigurationProperty.scheme.referenceKey) {
                return Scheme(rawValue: rawValue) ?? defaultValue
            }
            return defaultValue
        }
        set {
            defaults.set(newValue.rawValue, forKey: URLConfigurationProperty.scheme.referenceKey)
        }
    }
}
