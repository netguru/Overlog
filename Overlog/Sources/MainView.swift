//
//  OverlogView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class MainView: View {

    internal let tableView = UITableView(frame: .zero)
    internal let headerView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 220))
    internal let logoImageView = UIImageView(image: .init(namedInOverlogBundle: "logo"))
    internal let footerLabel = UILabel(frame: .zero)

    override func setupHierarchy() {
        [tableView, footerLabel].forEach { addSubview($0) }
        headerView.addSubview(logoImageView)
    }

    override func setupProperties() {
        [logoImageView, tableView, footerLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        backgroundColor = .OVLDarkBlue
        
        tableView.bounces = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        /// To hide empty cells
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView(frame: .zero)

        headerView.backgroundColor = .OVLDarkBlue
        
        footerLabel.text = "With ♥ from Netguru"
        footerLabel.textColor = .OVLWhite
        footerLabel.textAlignment = .center
        footerLabel.backgroundColor = .OVLDarkBlue
    }

    override func setupConstraints() {
        tableView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)

        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: footerLabel.topAnchor),
                
                logoImageView.heightAnchor.constraint(equalToConstant: 100),
                logoImageView.widthAnchor.constraint(equalToConstant: 100),
                logoImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                logoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -20),
                
                footerLabel.heightAnchor.constraint(equalToConstant: 60),
                footerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                footerLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
                footerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                footerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
//            var allConstraints = [NSLayoutConstraint]()
//
//            let views = [
//                "tableView": tableView,
//                "logoImageView": logoImageView
//            ]
//
//            let itemsHorizontalPositionConstraint = NSLayoutConstraint.constraints(
//                withVisualFormat: "V:|-64-[logoImageView(136)]-0-[tableView]-|",
//                options: [],
//                metrics: nil,
//                views: views
//            )
//            allConstraints += itemsHorizontalPositionConstraint
//
//            let logoImageViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
//                withVisualFormat: "H:|-(-8)-[logoImageView]-(-8)-|",
//                options: [],
//                metrics: nil,
//                views: views
//            )
//            allConstraints += logoImageViewHorizontalPositionConstraint
//
//
//            let tableViewVerticalPositionConstraint = NSLayoutConstraint.constraints(
//                withVisualFormat: "H:|-(-8)-[tableView]-(-8)-|",
//                options: [],
//                metrics: nil,
//                views: views
//            )
//
//            allConstraints += tableViewVerticalPositionConstraint
//
//            NSLayoutConstraint.activate(allConstraints)
        }
    }

}
