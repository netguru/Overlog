//
// SettingsViewController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class SettingsViewController: UITableViewController {
    
    /// A reuse identifier for the settings cell.
    fileprivate let reuseIdentifier = "SettingsViewTableCell"
    
    /// An array containing all available in-app features.
    fileprivate var availableFeatures: [FeatureType]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        availableFeatures = FeaturesDataSource().items.map { (value: Feature) -> FeatureType in
            return value.type
        }
        
        tableView.allowsSelection = false
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableFeatures.count
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        let feature = availableFeatures[indexPath.row]
        cell.toggle.isOn = UserDefaults.standard.bool(forKey: feature.defaultsKey)
        cell.textLabel?.text = feature.description
        cell.delegate = self
        return cell
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension SettingsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - SettingsTableViewCellDelegate

extension SettingsViewController: SettingsTableViewCellDelegate {
    
    func tableViewCell(_ tableViewCell: SettingsTableViewCell, didPerformActionWith control: UIControl) {
        guard let indexPath = tableView.indexPath(for: tableViewCell),
        let toggle = control as? UISwitch else {
            return
        }
        let feature = availableFeatures[indexPath.row]
        UserDefaults.standard.set(toggle.isOn, forKey: feature.defaultsKey)
    }
}

