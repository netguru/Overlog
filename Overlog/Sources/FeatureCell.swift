//
//  FeatureCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

final class FeatureCell: TableViewCell {

    internal let nameLabel = UILabel(frame: .zero)
    internal let counterLabel = UILabel(frame: .zero)

    override func setupHierarchy() {
        [nameLabel, counterLabel].forEach { contentView.addSubview($0) }
    }

    override func setupProperties() {
        [nameLabel, counterLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        
        counterLabel.layer.cornerRadius = 6
        counterLabel.textAlignment = .center
        counterLabel.clipsToBounds = true
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

                counterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                counterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                counterLabel.widthAnchor.constraint(equalToConstant: 24)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()

            let views = [
                "nameLabel": nameLabel,
                "counterLabel": counterLabel
            ]

            let horizontalViewsPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[nameLabel]-10-[counterLabel(24)]-20-|",
                options: [.alignAllCenterY],
                metrics: nil,
                views: views
            )
            allConstraints += horizontalViewsPositionConstraint

            let nameLabelSizingConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-20-[nameLabel]-20-|",
                options: [.alignAllCenterY],
                metrics: nil,
                views: views
            )

            allConstraints += nameLabelSizingConstraint

            NSLayoutConstraint.activate(allConstraints)
        }
    }
}
