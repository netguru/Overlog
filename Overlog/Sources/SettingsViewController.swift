//
// SettingsViewController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class SettingsViewController: UITableViewController {
    
    let reuseIdentifier = "SettingsViewTableCell"
    
    let availableFeatures: [FeatureType] = [.userDefaults, .network]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableFeatures.count
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = availableFeatures[indexPath.row].rawValue
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(didChangeValue(for:)), for: .valueChanged)
        cell.accessoryView = toggle
        return cell
    }
    
    // MARK: - Helpers
    
    @objc fileprivate func didChangeValue(for toggle: UISwitch) {
        
    }
}
