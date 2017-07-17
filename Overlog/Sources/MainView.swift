//
//  OverlogView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class MainView: View {

    internal let tableView = UITableView(frame: .zero)
    internal let logoImageView = UIImageView(frame: .zero)

    override func setupHierarchy() {
       [logoImageView, tableView].forEach { addSubview($0) }
    }

    override func setupProperties() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false


        tableView.bounces = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)

        /// To hide empty cells
        tableView.tableFooterView = UIView(frame: .zero)

        logoImageView.backgroundColor = .lightGray
    }

    override func setupConstraints() {

        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 64),
                logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                logoImageView.heightAnchor.constraint(equalToConstant: 136),
                logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()

            let views = [
                "tableView": tableView,
                "logoImageView": logoImageView
            ]

            let itemsHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-64-[logoImageView(136)]-0-[tableView]-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += itemsHorizontalPositionConstraint

            let logoImageViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(-8)-[logoImageView]-(-8)-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += logoImageViewHorizontalPositionConstraint


            let tableViewVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(-8)-[tableView]-(-8)-|",
                options: [],
                metrics: nil,
                views: views
            )

            allConstraints += tableViewVerticalPositionConstraint
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }

}
