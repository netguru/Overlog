//
//  RequestRepresentation.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
import ResponseDetective

extension RequestRepresentation: CustomDeserializable {

    func dictionaryRepresenation() -> [String : Any] {
        let bodyDictionary = try? { () throws -> [String : Any] in
            if let body = self.body, let data = try? JSONSerialization.jsonObject(with: body, options: []) {
                return data as? [String : Any] ?? [:]
            }
            return [:]
        }()
        return ["Method" : self.method,
                "URL" : self.urlString,
                "Headers" : self.headers,
                "Content Type": self.contentType,
                "Body" : bodyDictionary ?? ""]
    }
}
