//
//  KeychainItem.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

/// Default Keychain log keys
private enum Keys: String {
    case key = "key"
    case value = "value"
}

/// Overlog keychain model
public struct KeychainItem {
    
    let key: String
    let value: String
    
    /// Keychain model initializer
    ///
    /// - Parameters:
    ///   - raw: raw entry dictionary returned by Keychain Access 
    init(raw entry: [String: Any]) {
        key = entry[Keys.key.rawValue].map(String.init(describing:)) ?? "no key"
        value = entry[Keys.value.rawValue].map(String.init(describing:)) ?? "no value"
    }
    
}
