//
//  CustomDeserializable.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

internal enum DeserializationFormat {

    /// The JSON RFC 4627 represenation.
    case json
}

internal protocol CustomDeserializable {

    /// Dictionary represenation of object.
    ///
    /// - Returns: A dictionary containing object's fields.
    func dictionaryRepresenation() -> [String : String]
}

extension CustomDeserializable {

    /// Deserializes object to requestes format string represenation.
    ///
    /// - Parameter format: The format of the deserialization.
    /// - Returns: A string represenation if successful.
    /// - Throws: An error if deserialization was unsuccessful.
    func deserialize(with format: DeserializationFormat) throws -> String {
        switch format {
        case .json:
            let data = try JSONSerialization.data(withJSONObject: self.dictionaryRepresenation(), options: .prettyPrinted)
            return String(data: data, encoding: String.Encoding.utf8) ?? ""
        }
    }

}

