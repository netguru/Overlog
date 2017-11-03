//
//  UserDefaultsCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class UserDefaultsCell: TableViewCell {

    internal let keyLabel = UILabel(frame: .zero)
    internal let valueLabel = UILabel(frame: .zero)

    override func setupHierarchy() {
        [keyLabel, valueLabel].forEach { contentView.addSubview($0) }
    }

    override func setupProperties() {
        [keyLabel, valueLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        self.selectionStyle = .none
        valueLabel.numberOfLines = 0
        keyLabel.numberOfLines = 0
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {

            NSLayoutConstraint.activate([
                keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                keyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),

                valueLabel.topAnchor.constraint(equalTo: keyLabel.bottomAnchor, constant: 4),
                valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()

            let views = [
                "keyLabel": keyLabel,
                "valueLabel": valueLabel
            ]

            let keyLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[keyLabel]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += keyLabelHorizontalPositionConstraint

            let valueLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[valueLabel]|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += valueLabelHorizontalPositionConstraint

            let valueLabelVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[keyLabel]-4-[valueLabel]-4-|",
                options: [],
                metrics: nil,
                views: views
            )

            allConstraints += valueLabelVerticalPositionConstraint

            NSLayoutConstraint.activate(allConstraints)
        }
    }

}
