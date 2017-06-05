//
//  OverseerDelegate.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import ResponseDetective

/// An Overseer delegate protocol for notification whenever response, request or error appear in URLSession which Overseer is watching 
public protocol OverseerDelegate: class {
    
    /// Triggerd when Overseer gets new response
    ///
    /// - parameter overseer: object that get notice about a response
    /// - parameter response: recived response
    func overseer(overseer: Overseer?, didGet response: ResponseRepresentation)

    /// Triggerd when Overseer gets new request
    ///
    /// - parameter overseer: object that get notice about a request
    /// - parameter response: recived request
    func overseer(overseer: Overseer?, didGet request: RequestRepresentation)
    
    /// Triggerd when Overseer gets new error
    ///
    /// - parameter overseer: object that get notice about an error
    /// - parameter response: recived error
    func overseer(overseer: Overseer?, didGet error: ErrorRepresentation)
}
