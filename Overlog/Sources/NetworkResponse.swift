//
//  NetworkResponse.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

internal enum NetworkResponse {
    case success(response: Data)
    case error(error: Error)
}
