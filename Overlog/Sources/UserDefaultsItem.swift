//
//  UserDefaultsItem.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

/// Default user defaults keys
private enum Keys: String {
    case key = "key"
    case value = "value"
}

/// Overlog user defaults model
internal struct UserDefaultsItem {
    let key: String
    let value: String
}
