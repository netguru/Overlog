//
// MainViewController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal protocol MainViewControllerFlowDelegate: class {

    /// Tells the flow delegate that close button has been tapped.
    ///
    /// - Parameters:
    ///   - sender: a button responsible for sending the action
    func didTapCloseButton(with sender: UIBarButtonItem)
    
    /// Tells the flow delegate that settings button has been tapped.
    ///
    /// - Parameters:
    ///   - sender: a button responsible for sending the action
    func didTapSettingsButton(with sender: UIBarButtonItem)

    /// Tells the flow delegate that some feature was clicked.
    ///
    /// - Parameter feature: selected feature.
    func didSelect(feature: FeatureType)
}

internal final class MainViewController: UIViewController {

    /// A delegate responsible for sending flow controller callbacks
    internal weak var flowDelegate: MainViewControllerFlowDelegate?

    /// Custom view to be displayed
    internal let customView = MainView()

    /// Data source of all available features
    fileprivate let dataSource = FeaturesDataSource()
    
    // MARK: - View controller lifecycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    internal override func loadView() {
        view = customView
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Configure bar button item with 'close' option
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapCloseButton(with:)));
        let settingsBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(didTapSettingsButton(with:)))
        
        navigationItem.rightBarButtonItems = [closeBarButtonItem, settingsBarButtonItem]

        title = "Overlog".localized
        configure(tableView: customView.tableView)
        
        /// Add notification handling for changes in enabled features data source
        NotificationCenter.default.addObserver(forName: Feature.enabledFeaturesDidChangeNotificationKey, object: nil, queue: OperationQueue.main) { [unowned self] (notification: Notification) in
            self.customView.tableView.reloadData()
        }
    }
    
    // MARK: - Configuration

    private func configure(tableView: UITableView) {
        tableView.register(FeatureCell.self, forCellReuseIdentifier: String(describing: FeatureCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Target actions

fileprivate extension MainViewController {
    
    /// Sends the close action from bar button item to flow delegate.
    ///
    /// - Parameters:
    ///   - sender: a button responsible for sending the action
    @objc fileprivate func didTapCloseButton(with sender: UIBarButtonItem) {
        flowDelegate?.didTapCloseButton(with: sender)
    }
    
    /// Sends the settings action from bar button item to flow delegate.
    ///
    /// - Parameters:
    ///   - sender: a button responsible for sending the action
    @objc fileprivate func didTapSettingsButton(with sender: UIBarButtonItem) {
        flowDelegate?.didTapSettingsButton(with: sender)
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeatureCell.self), for: indexPath) as! FeatureCell

        cell.nameLabel.text = dataSource.enabledItems[indexPath.row].type.description
        
        if dataSource.enabledItems[indexPath.row].counter > 0 {
            cell.counterLabel.text = String(dataSource.enabledItems[indexPath.row].counter)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.enabledItems.count
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.flowDelegate?.didSelect(feature: dataSource.enabledItems[indexPath.row].type)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
