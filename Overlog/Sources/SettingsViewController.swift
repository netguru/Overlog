//
// SettingsViewController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal protocol SettingsViewControllerFlowDelegate: class {
    
    /// Tells the flow delegate that close button has been tapped.
    ///
    /// - Parameters:
    ///   - sender: a button responsible for sending the action
    func didTapCloseButton(with sender: UIBarButtonItem)
}

internal final class SettingsViewController: UITableViewController {
    
    /// A delegate responsible for sending flow controller callbacks
    internal weak var flowDelegate: SettingsViewControllerFlowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Configure right bar button item with 'close' option
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapCloseButton(with:)));
    }
}

// MARK: - Target actions

fileprivate extension SettingsViewController {
    
    /// Sends the close action from bar button item to flow delegate.
    ///
    /// - Parameters:
    ///   - sender: a button responsible for sending the action
    @objc fileprivate func didTapCloseButton(with sender: UIBarButtonItem) {
        flowDelegate?.didTapCloseButton(with: sender)
    }
    
}
