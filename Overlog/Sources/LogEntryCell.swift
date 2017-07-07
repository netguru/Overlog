//
//  LogEntryCell.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

internal final class LogEntryCell: TableViewCell {

    internal let dateLabel = UILabel(frame: .zero)
    internal let messageLabel = UILabel(frame: .zero)

    override func setupHierarchy() {
        [dateLabel, messageLabel].forEach { contentView.addSubview($0) }
    }

    override func setupProperties() {
        [dateLabel, messageLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        self.selectionStyle = .none
        dateLabel.numberOfLines = 0
        messageLabel.numberOfLines = 0
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {

            NSLayoutConstraint.activate([
                dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
                dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

                messageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
                messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
                ])
        }
    }
}
