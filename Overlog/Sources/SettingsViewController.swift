//
//  SettingsViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class SettingsViewController: UITableViewController {
    
    /// A reuse identifier for the settings cell.
    fileprivate let reuseIdentifier = "SettingsViewTableCell"
    
    /// Data source of available features
    fileprivate let featuresDataSource: FeaturesDataSource
    
    /// Cached available features taken from its data source.
    fileprivate var features: [Feature]
    
    init(featuresDataSource: FeaturesDataSource) {
        self.featuresDataSource = featuresDataSource;
        self.features = featuresDataSource.availableFeatures()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use init(featuresDataSource:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let feature = features[indexPath.row]
        cell.toggle.isOn = feature.enabled
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
        
        featuresDataSource.feature(features[indexPath.row].type, didEnable: toggle.isOn)
    }
}

