//
//  NetworkTrafficViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//


import UIKit

final class NetworkTrafficViewController: UIViewController {

    let customView = NetTrafficView()

    internal override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: customView.tableView)
    }

    internal override func loadView() {
        view = customView
    }
}

extension NetworkTrafficViewController {
    fileprivate func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NetworkTrafficCell.self, forCellReuseIdentifier: String(describing: NetworkTrafficCell.self))
        tableView.estimatedRowHeight = 64.0
    }

}

extension NetworkTrafficViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension NetworkTrafficViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NetworkTrafficCell.self), for: indexPath) as! NetworkTrafficCell

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
