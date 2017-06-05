//
//  Overseer.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import ResponseDetective

/// A class to oversee the network traffic
final public class Overseer {
    
    /// A configuration for the ResponseDetective
    private let configuration: URLSessionConfiguration
    
    /// An output facility for the ResponseDetective
    public let buffer = OverseerOutputFacility()
    
    /// Creates Owerwatch object
    public init(with configuration: URLSessionConfiguration) {
        self.configuration =  configuration
        ResponseDetective.outputFacility = buffer
        ResponseDetective.enable(inConfiguration: configuration)
    }
}
