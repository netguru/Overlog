//
//  KeychainMonitor.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

/// A class to monitor the keychain items
final public class KeychainMonitor {
    
    public var delegate: KeychainMonitorDelegate?
    
    /// A keychain associated with host application.
    fileprivate let keychain = Keychain()

    /// Perform a one-time scan for all keychain items stored by the host app
    public func subscribeForItems() {
        
        let items = keychain.allItems().map(KeychainItem.init(raw:))
        delegate?.monitor(self, didGet: items)
    }
}

/// A KeychainMonitorDelegate delegate protocol for notifying about new keychain items available.
public protocol KeychainMonitorDelegate: class {
    
    /// Triggerd when Monitor receives keychain items
    ///
    /// - parameter monitor: An object that get notice about a items.
    /// - parameter items: all keychain items gathered.
    func monitor(_ monitor: KeychainMonitor, didGet items: [KeychainItem])
}
