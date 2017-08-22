//
//  ResponseRepresentation.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
import ResponseDetective

extension ResponseRepresentation: CustomDeserializable {

    func dictionaryRepresenation() -> [String : String] {
        return ["Status Code " : self.statusString,
                "URL" : self.urlString,
                "Headers" : self.headers.description,
                "Content Type": self.contentType,
                "Body" : self.deserializedBody ?? ""]
    }
}
