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

    /// Tells the flow delegate that some feature was clicked.
    ///
    /// - Parameter feature: selected feature.
    func didSelect(feature: Overlog.Feature)
}

internal final class MainViewController: UIViewController {

    /// A delegate responsible for sending flow controller callbacks
    internal weak var flowDelegate: MainViewControllerFlowDelegate?

    /// Custom view to be displayed
    internal let customView = MainView()
    
    /// Cached enabled features taken from its data source.
    fileprivate var configuration: Overlog.Configuration
    
    // MARK: - View controller lifecycle
    
    init(configuration: Overlog.Configuration) {
        self.configuration = configuration;
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
        NotificationCenter.default.addObserver(forName: .overlogEnabledFeaturesDidChange, object: nil, queue: .main) { [unowned self] _ in
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
        let closeBarButtonItem = UIBarButtonItem(image: .init(namedInOverlogBundle: "button-close"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapCloseButton(with:)))
        
        navigationItem.leftBarButtonItem = closeBarButtonItem
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
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
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

        cell.nameLabel.text = configuration.sortedEnabledFeatures[indexPath.row].localizedTitle
        
        /// Hide bottom border in last cell
        if indexPath.row == configuration.sortedEnabledFeatures.count - 1 {
            cell.hideBorder()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration.sortedEnabledFeatures.count
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.flowDelegate?.didSelect(feature: configuration.sortedEnabledFeatures[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
}
