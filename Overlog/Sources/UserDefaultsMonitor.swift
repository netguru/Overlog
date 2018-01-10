//
//  UserDefaultsMonitor.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

extension UserDefaults: UserDefaultsMonitorDataSource {}

/// A class to monitor the user defaults
final internal class UserDefaultsMonitor {

    /// A delegate for notifying about new user defaults items available.
    internal var delegate: UserDefaultsMonitorDelegate?

    /// A data source associated with the host application.
    fileprivate let dataSource: UserDefaultsMonitorDataSource

    /// Initializes the monitor with a specific data source.
    ///
    /// - Parameter dataSource: a data source of user defaults items.
    init(dataSource: UserDefaultsMonitorDataSource) {
        self.dataSource = dataSource
    }

    /// Performs a one-time scan for all items stored in the user defaults.
    internal func subscribeForItems() {
        
        let dictionary = dataSource.dictionaryRepresentation().sorted(by: { $0.key < $1.key })
        let items = dictionary.map { UserDefaultsItem(key: $0, value: String(describing: $1)) }
        delegate?.monitor(self, didGet: items)
    }
}

/// A UserDefaultsMonitorDelegate delegate protocol for notifying about received user defaults items.
internal protocol UserDefaultsMonitorDelegate: class {
    
    /// Triggered when Monitor receives user defaults items
    ///
    /// - parameter monitor: An object that get notice about items.
    /// - parameter items: All user defaults items gathered.
    func monitor(_ monitor: UserDefaultsMonitor, didGet items: [UserDefaultsItem])
}

/// A data source for user defaults monitor.
internal protocol UserDefaultsMonitorDataSource: class {
    
    /// Obtains all items stored in the source.
    ///
    /// - Returns: Dictionary representation of all stored items.
    func dictionaryRepresentation() -> [String: Any]
}

