//
//  OverseerOutputFacility.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import ResponseDetective

/// An output facility for overseer
final public class OverseerOutputFacility: OutputFacility {
    
    /// An deleaget for a notifications
    weak public var delegate: OverseerDelegate?
    
    /// Overseer for a notifications
    weak var overseer: Overseer?
    
    /// A buffer of request representations.
    public private(set) var requestRepresentations: [RequestRepresentation] = []
    
    /// A buffer of request representations.
    public private(set) var responseRepresentations: [ResponseRepresentation] = []
    
    /// A buffer of request representations.
    public private(set) var errorRepresentations: [ErrorRepresentation] = []
    
    // MARK: OutputFacility
    
    /// Adds the request representation to the buffer.
    ///
    /// - SeeAlso: OutputFacility.output(requestRepresentation:)
    public func output(requestRepresentation request: RequestRepresentation) {
        requestRepresentations.append(request)
        delegate?.overseer(overseer: overseer, didGet: request)
    }
    
    /// Adds the response representation to the buffer.
    ///
    /// - SeeAlso: OutputFacility.output(responseRepresentation:)
    public func output(responseRepresentation response: ResponseRepresentation) {
        responseRepresentations.append(response)
        delegate?.overseer(overseer: overseer, didGet: response)
    }
    
    /// Adds the error representation to the buffer.
    ///
    /// - SeeAlso: OutputFacility.output(errorRepresentation:)
    public func output(errorRepresentation error: ErrorRepresentation) {
        errorRepresentations.append(error)
        delegate?.overseer(overseer: overseer, didGet: error)
    }
}
