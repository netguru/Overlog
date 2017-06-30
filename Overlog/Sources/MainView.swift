//
//  OverlogView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.

import UIKit

internal final class MainView: View {


    internal let tableView = UITableView(frame: .zero)
    internal let logoImageView = UIImageView(frame: .zero)


    override func setupHierarchy() {
        addSubview(logoImageView)
        addSubview(tableView)
    }

    override func setupProperties() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.separatorStyle = .singleLine
        logoImageView.backgroundColor = .cyan
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
                ]
            )
        }
    }

}
