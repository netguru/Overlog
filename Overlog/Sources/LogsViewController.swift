//
//  LogsViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class LogsViewController: UIViewController {

    /// Custom view to be displayed
    internal let customView = TableView()

    /// Array of recently found logs
    fileprivate(set) var logs = [LogEntry]()
    
    /// Date formatter used for formatting dates from log models.
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter
    }()

    internal override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Overlog.Feature.logs.localizedTitle
        configure(tableView: customView.tableView)
    }

    internal override func loadView() {
        view = customView
    }

    internal func reload(with newLogs: [LogEntry]) {
        logs = newLogs
        customView.tableView.reloadData()
    }

}

extension LogsViewController {
    fileprivate func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(KeyValueEntryCell.self, forCellReuseIdentifier: String(describing: KeyValueEntryCell.self))
        tableView.estimatedRowHeight = 44.0
    }
    
    fileprivate func stringify(date: Date?) -> String {
        if let date = date {
            let stringDate = dateFormatter.string(from: date)
            if stringDate.count != 0 {
                return stringDate
            }
        }
        return "-"
    }
}

extension LogsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: KeyValueEntryCell.self), for: indexPath) as! KeyValueEntryCell
        let log = logs[indexPath.row]

        let valueText = stringify(date: log.date)
        let keyText = "\(log.sender) \(log.message)"
        cell.keyLabel.text = valueText
        cell.valueLabel.text = keyText
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension LogsViewController: UITableViewDelegate {
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
