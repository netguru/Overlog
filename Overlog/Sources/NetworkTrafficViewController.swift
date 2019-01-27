//
//  NetworkTrafficViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal protocol NetworkTrafficViewControllerFlowDelegate: class {

    /// Tells the flow delegate that controller did select a network traffic entry.
    ///
    /// - Parameter networkTrafficEntry: Selected a networktraffic entry.
    func didSelect(networkTrafficEntry: NetworkTrafficEntry)
}

final class NetworkTrafficViewController: UIViewController {

    internal let customView = TableView()
    fileprivate var networkTrafficEntries: [NetworkTrafficEntry]

    /// Delegate of the network traffic view controller.
    internal weak var flowDelegate: NetworkTrafficViewControllerFlowDelegate?

    init(networkTrafficEntries: [NetworkTrafficEntry]) {
        self.networkTrafficEntries = networkTrafficEntries
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use init(networkTraffics:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: customView.tableView)
    }

    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = Overlog.Feature.httpTraffic.localizedTitle
        if let indexPath = customView.tableView.indexPathForSelectedRow {
            customView.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    internal override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }

    internal override func loadView() {
        view = customView
    }

    /// Reloads view controller content with received entry.
    ///
    /// - Parameter entry: Network entry which should be displayed by the view controller.
    internal func reload(with entry: NetworkTrafficEntry) {
        if let index = networkTrafficEntries.index(where: { $0 === entry }) {
            let indexPath = IndexPath(row: index, section: 0)
            customView.tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let lastRow = customView.tableView.numberOfRows(inSection: 0) - 1
            let indexPath = IndexPath(row: lastRow + 1, section: 0)
            networkTrafficEntries.append(entry)
            customView.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}

extension NetworkTrafficViewController {
    fileprivate func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NetworkTrafficCell.self, forCellReuseIdentifier: String(describing: NetworkTrafficCell.self))
        tableView.estimatedRowHeight = 44.0
    }
}

extension NetworkTrafficViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.flowDelegate?.didSelect(networkTrafficEntry: networkTrafficEntries[indexPath.row])
    }
}

extension NetworkTrafficViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NetworkTrafficCell.self), for: indexPath) as! NetworkTrafficCell
        let entry = networkTrafficEntries[indexPath.row]
        cell.setup(withEntry: entry)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkTrafficEntries.count
    }
}
