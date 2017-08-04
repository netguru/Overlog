//
//  NetworkProtocol.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

internal protocol NetworkProtocol {
    func performRequest(with parameters: Dictionary<String, Any>?, completionHandler: @escaping (NetworkResponse) -> ())
}
