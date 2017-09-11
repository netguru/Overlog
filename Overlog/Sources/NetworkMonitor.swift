//
//  NetworkMonitor.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import ResponseDetective

/// A class to monitor the network traffic
final public class NetworkMonitor {
    
    /// An deleaget for a notifications
    weak public var delegate: NetworkMonitorDelegate?
    
    /// A buffer of request representations.
    public fileprivate(set) var requestRepresentations: [RequestRepresentation] = []
    
    /// A buffer of request representations.
    public fileprivate(set) var responseRepresentations: [ResponseRepresentation] = []
    
    /// A buffer of request representations.
    public fileprivate(set) var errorRepresentations: [ErrorRepresentation] = []
    
    private init() {
        ResponseDetective.outputFacility = self
    }

    /// Shared instance
    public static let shared = NetworkMonitor()

    /// Adds a configuration on which monitor will be observing the network traffic
    ///
    /// - parameter configuration: an configuration for watching
    public func watch(on configuration: URLSessionConfiguration) {
        ResponseDetective.enable(inConfiguration: configuration)
    }
}

extension NetworkMonitor: OutputFacility {
    
    /// Adds the request representation to the buffer.
    ///
    /// - parameter response: object that represent request
    public func output(requestRepresentation request: RequestRepresentation) {
        requestRepresentations.append(request)
        DispatchQueue.main.async {
            self.delegate?.monitor(self, didGet: request)
        }
    }
    
    /// Adds the response representation to the buffer.
    ///
    /// - parameter response: object that represent request's response
    public func output(responseRepresentation response: ResponseRepresentation) {
        responseRepresentations.append(response)
        DispatchQueue.main.async {
            self.delegate?.monitor(self, didGet: response)
        }
    }
    
    /// Adds the error representation to the buffer.
    ///
    /// - parameter response: object that represent request's error
    public func output(errorRepresentation error: ErrorRepresentation) {
        errorRepresentations.append(error)
        DispatchQueue.main.async {
            self.delegate?.monitor(self, didGet: error)
        }
    }
}

/// An NetworkMonitorDelegate delegate protocol for notification whenever response, request or error appear in URLSession which monitor is watching
public protocol NetworkMonitorDelegate: class {
    
    /// Triggered when Monitor gets new response
    ///
    /// - parameter monitor: An object that get notice about a response
    /// - parameter response: received response
    func monitor(_ monitor: NetworkMonitor, didGet response: ResponseRepresentation)
    
    /// Triggered when Monitor gets new request
    ///
    /// - parameter monitor: An object that get notice about a request
    /// - parameter response: received request
    func monitor(_ monitor: NetworkMonitor, didGet request: RequestRepresentation)
    
    /// Triggered when Monitor gets new error
    ///
    /// - parameter monitor: An object that get notice about an error
    /// - parameter response: received error
    func monitor(_ monitor: NetworkMonitor, didGet error: ErrorRepresentation)
}
