//
//  NetworkTrafficViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

final class NetworkTrafficViewController: UIViewController {

    let customView = TableView()
    fileprivate let networkTraffics: [NetworkTraffic]

    init(networkTraffics: [NetworkTraffic]) {
        self.networkTraffics = networkTraffics

        super.init(nibName: nil, bundle: nil)
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: customView.tableView)
    }

    internal override func loadView() {
        view = customView
    }

    @available(*, unavailable, message: "Use init(networkTraffics:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trafficDetailsViewController = TrafficDetailsViewController(networkTraffic: networkTraffics[indexPath.row])
        navigationController?.pushViewController(trafficDetailsViewController, animated: true)

    }
}

extension NetworkTrafficViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NetworkTrafficCell.self), for: indexPath) as! NetworkTrafficCell

        cell.requestTypeLabel.text = "Request".localized

        let currentRequest = networkTraffics[indexPath.row].request
        cell.requestURLLabel.text = currentRequest.urlString

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkTraffics.count
    }
}
