//
//  Overseer.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import ResponseDetective

/// A class to oversee the network traffic
final public class Overseer {
    
    /// An deleaget for a notifications
    weak public var delegate: OverseerDelegate?
    
    /// A buffer of request representations.
    public fileprivate(set) var requestRepresentations: [RequestRepresentation] = []
    
    /// A buffer of request representations.
    public fileprivate(set) var responseRepresentations: [ResponseRepresentation] = []
    
    /// A buffer of request representations.
    public fileprivate(set) var errorRepresentations: [ErrorRepresentation] = []
    
    /// Creates Owerwatch object
    ///
    public init() {
        ResponseDetective.outputFacility = self
    }
    
    /// Adds a configuration on which Overseer will be observing the network traffic
    ///
    /// - parameter configuration: an configuration for watching
    public func watch(on configuration: URLSessionConfiguration) {
        ResponseDetective.enable(inConfiguration: configuration)
    }
}

extension Overseer: OutputFacility {
    
    /// Adds the request representation to the buffer.
    ///
    /// - parameter response: object that represent request
    public func output(requestRepresentation request: RequestRepresentation) {
        requestRepresentations.append(request)
        delegate?.overseer(overseer: self, didGet: request)
    }
    
    /// Adds the response representation to the buffer.
    ///
    /// - parameter response: object that represent request's response
    public func output(responseRepresentation response: ResponseRepresentation) {
        responseRepresentations.append(response)
        delegate?.overseer(overseer: self, didGet: response)
    }
    
    /// Adds the error representation to the buffer.
    ///
    /// - parameter response: object that represent request's error
    public func output(errorRepresentation error: ErrorRepresentation) {
        errorRepresentations.append(error)
        delegate?.overseer(overseer: self, didGet: error)
    }
}
