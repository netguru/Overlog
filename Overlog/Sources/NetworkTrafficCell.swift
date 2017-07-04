//
//  NetworkTrafficCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class NetworkTrafficCell: TableViewCell {

    let typeLabel = UILabel(frame: .zero)
    let urlLabel = UILabel(frame: .zero)
    let responseLabel = UILabel(frame: .zero)


    internal override func setupHierarchy() {
        [typeLabel, urlLabel, responseLabel].forEach { contentView.addSubview($0) }
    }

    internal override func setupProperties() {
        responseLabel.numberOfLines = 0
    }

    internal override func setupConstraints() {

        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                typeLabel.widthAnchor.constraint(equalToConstant: 64),

                urlLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 4),
                urlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4),

                responseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                responseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
                responseLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 4),
                responseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4)
            ])
        }
    }
}
