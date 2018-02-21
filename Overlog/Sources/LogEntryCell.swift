//
//  LogEntryCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class KeyValueEntryCell: TableViewCell {

    internal let dateLabel = UILabel(frame: .zero)
    internal let messageLabel = UILabel(frame: .zero)
    internal let bottomFill = UIView(frame: .zero)

    override func setupHierarchy() {
        [dateLabel, messageLabel, bottomFill].forEach { contentView.addSubview($0) }
    }

    override func setupProperties() {
        [dateLabel, messageLabel, bottomFill].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [dateLabel, messageLabel].forEach { $0.textColor = .OVLWhite }

        dateLabel.numberOfLines = 0
        messageLabel.numberOfLines = 0
        backgroundColor = .OVLGray
        selectionStyle = .none
        
        if #available(iOSApplicationExtension 8.2, *) {
            dateLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        } else {
            dateLabel.font = UIFont.systemFont(ofSize: 16)
        }
        
        bottomFill.backgroundColor = .OVLDarkBlue
        bottomFill.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

                messageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
                messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                messageLabel.bottomAnchor.constraint(equalTo: bottomFill.topAnchor, constant: -16),
                
                bottomFill.heightAnchor.constraint(equalToConstant: 16),
                bottomFill.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bottomFill.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomFill.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
}
