//
//  UserDefaultsViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal protocol UserDefaultsViewControllerFlowDelegate: class {

    /// Tells the flow delegate that share button has been tapped.
    ///
    /// - Parameters:
    ///   - sender: a button responsible for sending the action
    func didTapShareButton(withItems activityItems: [Any])
}

internal final class UserDefaultsViewController: UIViewController {

    /// Custom view to be displayed
    internal let customView = TableView()

    /// Dictionary representation of user defaults
    fileprivate let userDefaultsDictionary = UserDefaults.standard.dictionaryRepresentation()

    /// A delegate responsible for sending flow controller callbacks
    internal weak var flowDelegate: UserDefaultsViewControllerFlowDelegate?

    internal override func viewDidLoad() {
        super.viewDidLoad()
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonPressed))

        self.navigationItem.rightBarButtonItem = shareButton
        configure(tableView: customView.tableView)
    }

    internal override func loadView() {
        view = customView
    }
}

extension UserDefaultsViewController {
    fileprivate func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserDefaultsCell.self, forCellReuseIdentifier: String(describing: UserDefaultsCell.self))
        tableView.estimatedRowHeight = 44.0
    }

    @objc fileprivate func shareButtonPressed() {
        self.flowDelegate?.didTapShareButton(withItems: ["User Defaults", String(describing: userDefaultsDictionary) ])
    }
}

extension UserDefaultsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDefaultsDictionary.keys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserDefaultsCell.self), for: indexPath) as! UserDefaultsCell

        let currentKey = userDefaultsDictionary.keys.sorted()[indexPath.row]

        cell.keyLabel.text = String(currentKey)
        cell.valueLabel.text = userDefaultsDictionary[currentKey].map { String(describing: $0) } ?? "unknown value"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension UserDefaultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }

    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            if let cell = tableView.cellForRow(at: indexPath) as? UserDefaultsCell {
                guard let keyString = cell.keyLabel.text else {
                    return
                }

                let pasteboard = UIPasteboard.general
                pasteboard.string = "\(keyString): \(cell.valueLabel.text ?? "")"
            }
        }
    }
}
