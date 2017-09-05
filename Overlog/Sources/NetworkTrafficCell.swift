//
//  NetworkTrafficCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class NetworkTrafficCell: TableViewCell {

    let requestTypeLabel = UILabel(frame: .zero)
    let requestURLLabel = UILabel(frame: .zero)

    internal override func setupHierarchy() {
        [requestTypeLabel, requestURLLabel].forEach { contentView.addSubview($0) }
    }

    internal override func setupProperties() {
        [requestTypeLabel, requestURLLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        requestTypeLabel.textColor = .white
        requestTypeLabel.layer.cornerRadius = 4
        requestTypeLabel.clipsToBounds = true
        requestTypeLabel.textAlignment = .center

        requestTypeLabel.backgroundColor = .blue

        self.accessoryType = .disclosureIndicator
    }

    internal override func setupConstraints() {

        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                requestTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                requestTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                requestTypeLabel.widthAnchor.constraint(equalToConstant: 96),

                requestURLLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                requestURLLabel.topAnchor.constraint(equalTo: requestTypeLabel.bottomAnchor, constant: 16),
                requestURLLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)

            ])
        }
    }

    internal override func setSelected(_ selected: Bool, animated: Bool) {
        let backgroundColor = requestTypeLabel.backgroundColor
        super.setSelected(selected, animated: animated)

        if selected {
            requestTypeLabel.backgroundColor = backgroundColor
        }
    }
}
