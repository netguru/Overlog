//
// URLRequestExtensions.swift
//
// Copyright © 2018 Netguru Sp. z o.o.. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

internal extension URLRequest {

    /// Create a GET request.
    ///
    /// - Parameters:
    ///     - url: URL of request.
    ///
    /// - Returns: An URL request.
    internal static func get(url: String) -> URLRequest {
        return URLRequest(url: URL(string: url)!)
    }

    /// Create a POST request.
    ///
    /// - Parameters:
    ///     - url: URL of request.
    ///     - body: String body data of request.
    ///
    /// - Returns: An URL request.
    internal static func post(url: String, body: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8)
        request.addValue("text/plain", forHTTPHeaderField: "content-type")
        return request
    }

}
