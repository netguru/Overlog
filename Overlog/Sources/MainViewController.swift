//
// SettingsViewController.swift
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

    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Configure right bar button item with 'close' option
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapCloseButton(with:)));

        self.title = "Overlog"

        configure(tableView: customView.tableView)
    }

    internal override func loadView() {
        view = customView
    }

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
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeatureCell.self), for: indexPath) as! FeatureCell

        cell.nameLabel.text = dataSource.items[indexPath.row].type.description
        
        if dataSource.items[indexPath.row].counter > 0 {
            cell.counterLabel.text = String(dataSource.items[indexPath.row].counter)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.items.count
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.flowDelegate?.didSelect(feature: dataSource.items[indexPath.row].type)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
