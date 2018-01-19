//
//  UserDefaultsView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

final class TableView: View {

    internal let tableView = UITableView(frame: .zero)

    override func setupHierarchy() {
        addSubview(tableView)
    }

    override func setupProperties() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.indicatorStyle = .white
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = .OVLDarkBlue
        tableView.separatorStyle = .none
        /// To hide empty cells
        tableView.tableFooterView = UIView(frame: .zero)
    }

    override func setupConstraints() {

        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()

            let views = [
                "tableView": tableView
            ]

            let tableViewVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[tableView]-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += tableViewVerticalPositionConstraint

            let tableViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[tableView]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += tableViewHorizontalPositionConstraint

            NSLayoutConstraint.activate(allConstraints)
        }
    }
}
