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
    fileprivate var logsMonitor: LogsMonitor

    /// Array of recently found logs
    fileprivate(set) var logs = [LogEntry]()
    
    /// Date formatter used for formatting dates from log models.
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter
    }()

    /// Initialize the view controller with a specific LogsMonitor
    ///
    /// - parameter logsMonitor: a console or system logs monitor
    init(logsMonitor: LogsMonitor) {
        self.logsMonitor = logsMonitor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView: customView.tableView)
    }

    internal override func loadView() {
        view = customView
    }

    public func reload(with newLogs: [LogEntry]) {
        logs = newLogs
        customView.tableView.reloadData()
    }

}

extension LogsViewController {
    fileprivate func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LogEntryCell.self, forCellReuseIdentifier: String(describing: LogEntryCell.self))
        tableView.estimatedRowHeight = 44.0
    }
    
    fileprivate func stringify(date: Date?) -> String {
        if let date = date {
            let stringDate = dateFormatter.string(from: date)
            if stringDate.characters.count != 0 {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LogEntryCell.self), for: indexPath) as! LogEntryCell
        let log = logs[indexPath.row]

        cell.dateLabel.text = stringify(date: log.date)
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
