//
//  LogsViewController.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

internal final class LogsViewController: UIViewController {
    
    /// Custom view to be displayed
    internal let customView = UserDefaultsView()
    
    /// Instance of a class which enables searching for logs
    fileprivate let logsMonitor = LogsMonitor()

    /// Array of recently found logs
    fileprivate(set) var logs = [Log]()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        logs = logsMonitor.scanForLogs()
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
        tableView.register(UserDefaultsCell.self, forCellReuseIdentifier: String(describing: UserDefaultsCell.self))
        tableView.estimatedRowHeight = 44.0
    }
}

extension LogsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserDefaultsCell.self), for: indexPath) as! UserDefaultsCell

        let log = logs[indexPath.row]
        cell.keyLabel.text = log.timestamp
        cell.valueLabel.text = "\(log.sender) \(log.message)"
        cell.valueLabel.lineBreakMode = .byWordWrapping
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
