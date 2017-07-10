//
//  NetworkTrafficEntry.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
import ResponseDetective

internal class NetworkTrafficEntry {
    var request: RequestRepresentation
    var response: ResponseRepresentation?
    var error: ErrorRepresentation?

    init(request: RequestRepresentation) {
        self.request = request
        self.response = nil
        self.error = nil
    }
}
