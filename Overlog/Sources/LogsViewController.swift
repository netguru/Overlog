//
//  LogsViewController.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

internal final class LogsViewController: UIViewController {

    /// Custom view to be displayed
    internal let customView = TableView()

    /// Instance of a class which enables searching for logs
    fileprivate let logsMonitor: LogsMonitor

    /// Array of recently found logs
    fileprivate(set) var logs = [LogEntry]()

    init(logsMonitor: LogsMonitor) {
        self.logsMonitor = logsMonitor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        logsMonitor.delegate = self
        logsMonitor.subscribeForLogs()
        configure(tableView: customView.tableView)
    }

    internal override func loadView() {
        view = customView
    }
}

extension LogsViewController {
    fileprivate func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LogEntryCell.self, forCellReuseIdentifier: String(describing: LogEntryCell.self))
        tableView.estimatedRowHeight = 44.0
    }
}

extension LogsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LogEntryCell.self), for: indexPath) as! LogEntryCell

        let log = logs[indexPath.row]
        cell.dateLabel.text = log.timestamp
        cell.messageLabel.text = "\(log.sender) \(log.message)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
            if let cell = tableView.cellForRow(at: indexPath) as? LogEntryCell {
                let pasteboard = UIPasteboard.general
                pasteboard.string = "\(cell.dateLabel.text ?? ""): \(cell.messageLabel.text ?? "")"
            }
        }
    }
}

extension LogsViewController: LogsMonitorDelegate {

    func monitor(_ monitor: LogsMonitor, didGet logs: [LogEntry]) {
        self.logs = logs
        customView.tableView.reloadData()
    }

}
