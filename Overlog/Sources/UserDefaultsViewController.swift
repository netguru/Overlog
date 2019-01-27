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

    /// Custom view to be displayed.
    internal let customView = TableView()

    /// Array of recently found user defaults items.
    fileprivate(set) var items = [UserDefaultsItem]()

    /// String representation of user defaults formatted with XML format
    fileprivate var userDefaultsXMLFormattedStringRepresentation: String? {
        do {
            let propertyList = UserDefaults.standard.dictionaryRepresentation()
            let data = try PropertyListSerialization.data(fromPropertyList: propertyList, format: .xml, options: 0)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }

    /// A delegate responsible for sending flow controller callbacks
    internal weak var flowDelegate: UserDefaultsViewControllerFlowDelegate?

    internal override func viewDidLoad() {
        super.viewDidLoad()
        let shareButton = UIBarButtonItem(image: UIImage(namedInOverlogBundle: "button-share"), style: .plain, target: self, action: #selector(shareButtonPressed))
        navigationItem.rightBarButtonItem = shareButton
        navigationItem.title = Overlog.Feature.userDefaults.localizedTitle
        configure(tableView: customView.tableView)
    }

    internal override func loadView() {
        view = customView
    }

    internal func reload(with newItems: [UserDefaultsItem]) {
        items = newItems
        customView.tableView.reloadData()
    }

}

extension UserDefaultsViewController {
    fileprivate func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(KeyValueEntryCell.self, forCellReuseIdentifier: String(describing: KeyValueEntryCell.self))
        tableView.estimatedRowHeight = 44.0
    }

    @objc fileprivate func shareButtonPressed() {
        if let stringifiedXML = userDefaultsXMLFormattedStringRepresentation {
            flowDelegate?.didTapShareButton(withItems: [stringifiedXML])
        }
    }
}

extension UserDefaultsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: KeyValueEntryCell.self), for: indexPath) as! KeyValueEntryCell
        let item = items[indexPath.row]
        cell.keyLabel.text = item.key
        cell.valueLabel.text = item.value
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
            if let cell = tableView.cellForRow(at: indexPath) as? KeyValueEntryCell {
                let pasteboard = UIPasteboard.general
                pasteboard.string = "\(cell.keyLabel.text ?? ""): \(cell.valueLabel.text ?? "")"
            }
        }
    }
}
