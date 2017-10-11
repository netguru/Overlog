//
//  Scheme.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

/// String representation of scheme.
///
/// - http: Regular communication protocol.
/// - https: Secure communication protocol.
internal enum Scheme: String {
    case http = "HTTP"
    case https = "HTTPS"
}
