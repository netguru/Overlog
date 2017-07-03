//
//  UserDefaultsViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class UserDefaultsViewController: UIViewController {

    /// Custom view to be displayed
    internal let customView = UserDefaultsView()
    fileprivate let userDefaultsDictionary = UserDefaults.standard.dictionaryRepresentation()

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(UserDefaultsCell.self, forCellReuseIdentifier: String(describing: UserDefaultsCell.self))
        customView.tableView.estimatedRowHeight = 44.0
    }

    override func loadView() {
        view = customView
    }
}

extension UserDefaultsViewController: UITableViewDelegate {

}

extension UserDefaultsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDefaultsDictionary.keys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserDefaultsCell.self), for: indexPath) as! UserDefaultsCell

        let currentKey = userDefaultsDictionary.keys.sorted()[indexPath.row]

        cell.keyLabel.text = String(currentKey)
        cell.valueLabel.text = userDefaultsDictionary[currentKey] as? String
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
