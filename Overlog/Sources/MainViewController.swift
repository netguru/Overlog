//
//  MainViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
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

    /// Data source of available features
    fileprivate let featuresDataSource: FeaturesDataSource
    
    /// Cached enabled features taken from its data source.
    fileprivate var features: [Feature]
    
    // MARK: - View controller lifecycle
    
    init(featuresDataSource: FeaturesDataSource) {
        self.featuresDataSource = featuresDataSource;
        self.features = featuresDataSource.enabledFeatures()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use init(featuresDataSource:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    internal override func loadView() {
        view = customView
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(tableView: customView.tableView)
        configure(navigationItem: navigationItem)
        configure(navigationBar: navigationController?.navigationBar)
        
        /// Add notification handling for changes in enabled features data source
        NotificationCenter.default.addObserver(forName: featuresDataSource.enabledFeaturesDidChangeNotificationKey, object: nil, queue: OperationQueue.main) { [unowned self] (notification: Notification) in
            self.features = self.featuresDataSource.enabledFeatures()
            self.customView.tableView.reloadData()
        }
    }
    
    // MARK: - Configuration

    /// Configures table view
    ///
    /// - Parameter tableView: table view to configure
    private func configure(tableView: UITableView) {
        tableView.register(FeatureCell.self, forCellReuseIdentifier: String(describing: FeatureCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// Configures navigation item
    ///
    /// - Parameter navigationItem: navigation item to configure
    private func configure(navigationItem: UINavigationItem) {
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapCloseButton(with:)));
        let settingsBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(didTapSettingsButton(with:)))
        
        navigationItem.leftBarButtonItem = closeBarButtonItem
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        navigationItem.title = ""
    }
    
    /// Configures navigastion bar
    ///
    /// - Parameter navigationBar: navigation bar to configure
    private func configure(navigationBar: UINavigationBar?) {
        navigationBar?.isTranslucent = false
        navigationBar?.barStyle = .blackOpaque
        navigationBar?.tintColor = .OVLWhite
        navigationBar?.barTintColor = .OVLDarkBlue
        navigationBar?.shadowImage = UIImage()
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

        let feature = features[indexPath.row]
        cell.nameLabel.text = feature.description
        if feature.counter > 0 {
            cell.counterLabel.text = String(feature.counter)
        }
        
        /// Hide bottom border in last cell
        if indexPath.row + 1 == features.count {
            cell.hideBorder()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.flowDelegate?.didSelect(feature: features[indexPath.row].type)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
