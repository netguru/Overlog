//
//  RequestRepresentation.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
import ResponseDetective

extension RequestRepresentation: CustomDeserializable {
    
    func dictionaryRepresenation() -> [String : String] {
        return ["Method" : self.method,
                "URL" : self.urlString,
                "Headers" : self.headers.description,
                "Content Type": self.contentType,
                "Body" : self.deserializedBody ?? ""]
    }
}
