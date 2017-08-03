//
//  Network.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

fileprivate protocol NetworkProtocol {
    func performRequest(completionHandler: (NetworkResponse) -> ())
}

internal enum Network: NetworkProtocol {
    case get(url: NSURL)
    case post(url: NSURL, data: String)
    
    func performRequest(completionHandler: (NetworkResponse) -> ()) {
    }
}

internal enum NetworkResponse {
    case success(response: String)
    case error(error: String)
}
