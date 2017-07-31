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
    
    /// Array representation of keychain keys
    fileprivate var keys: [String] = Keychain().allKeys()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
}

// MARK: UITableViewDataSource

extension KeychainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        cell.textLabel?.text = keys[indexPath.row]
        return cell
    }
    
}
