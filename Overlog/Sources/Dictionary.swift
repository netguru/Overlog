//
//  Dictionary.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

internal extension Dictionary {
    
    /// Returns string with format:
    /// Key1: value
    /// Key2: value
    internal var keyValueString: String? {
        guard !isEmpty else { return nil }
        var prettyString = ""
        for element in self {
            prettyString += "\(element.key): \(element.value)\n"
        }
        /// Remove new line added at the end
        prettyString.removeLast()

        return prettyString
    }
}
