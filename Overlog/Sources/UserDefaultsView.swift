//
//  UserDefaultsView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

final class UserDefaultsView: View {

    internal let tableView = UITableView(frame: .zero)

    override func setupHierarchy() {
        addSubview(tableView)
    }

    override func setupProperties() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.separatorStyle = .singleLine

        /// To hide empty cells
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.bounces = false

    }

    override func setupConstraints() {

        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}
