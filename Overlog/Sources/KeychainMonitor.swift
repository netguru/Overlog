//
//  KeychainMonitor.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

extension Keychain: KeychainMonitorDataSource {}

/// A class to monitor the keychain items
final public class KeychainMonitor {

    /// A delegate for notifying about new keychain items available.
    public var delegate: KeychainMonitorDelegate?

    /// A keychain data source associated with the host application.
    fileprivate let dataSource: KeychainMonitorDataSource

    /// Initializes the monitor with a specific data source.
    ///
    /// - Parameter dataSource: a data source of keychain items.
    init(dataSource: KeychainMonitorDataSource) {
        self.dataSource = dataSource
    }

    /// Performs a one-time scan for all keychain items stored by the host app.
    public func subscribeForItems() {
        
        let items = dataSource.allItems().map(KeychainItem.init(raw:))
        delegate?.monitor(self, didGet: items)
    }
}

/// A KeychainMonitorDelegate delegate protocol for notifying about received keychain items.
public protocol KeychainMonitorDelegate: class {

    /// Triggered when Monitor receives keychain items
    ///
    /// - parameter monitor: An object that get notice about items.
    /// - parameter items: All keychain items gathered.
    func monitor(_ monitor: KeychainMonitor, didGet items: [KeychainItem])
}

/// A data source for keychain monitor.
public protocol KeychainMonitorDataSource: class {

    /// Obtains all items stored in the keychain.
    ///
    /// - Returns: All stored items.
    func allItems() -> [[String: Any]]
}
