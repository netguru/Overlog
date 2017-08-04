//
//  NetworkProtocol.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

internal protocol NetworkProtocol {
    associatedtype NetworkParameters
    
    func performRequest(with parameters: NetworkParameters?, completionHandler: @escaping (NetworkResponse) -> ())
}
