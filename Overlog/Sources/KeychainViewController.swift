//
//  KeychainViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class KeychainViewController: UITableViewController {
    
    /// A reuse identifier for keychain view cells
    fileprivate let reuseIdentifier = "KeychainViewCellReuseIdentifier"
    
    /// Array representation of keychain entries
    fileprivate var keychainEntries: [KeychainEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keychain = KeychainManager()
        keychainEntries = keychain.allEntries().map { (value: [String : String]) -> KeychainEntry in
            return KeychainEntry(with: value)
        }
        
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
}

// MARK: UITableViewDataSource

extension KeychainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keychainEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        let entry = keychainEntries[indexPath.row]
        cell.textLabel?.text = entry.keyName
        if let service = entry.serviceName {
            cell.detailTextLabel?.text = "Service: \(service)"
        }
        
        return cell
    }
    
}
