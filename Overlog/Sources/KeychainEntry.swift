//
//  KeychainEntry.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

/// A keychain entry model containing key name and name of a service associated with the entry.
struct KeychainEntry {
    
    /// A name of the key in given keychain entry.
    let keyName: String
    
    /// A name of service associated to given keychain entry.
    fileprivate(set) var serviceName: String?
    
    init(with dictionary:[String:String]) {
        keyName = dictionary[OVLKeychainManagerKeyReference]!
        serviceName = dictionary[OVLKeychainManagerServiceReference]
    }

}
