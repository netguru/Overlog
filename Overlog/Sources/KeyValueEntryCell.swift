//
//  KeyValueEntryCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class KeyValueEntryCell: TableViewCell {

    internal let keyLabel = UILabel(frame: .zero)
    internal let valueLabel = UILabel(frame: .zero)
    internal let bottomFill = UIView(frame: .zero)

    override func setupHierarchy() {
        [keyLabel, valueLabel, bottomFill].forEach { contentView.addSubview($0) }
    }

    override func setupProperties() {
        [keyLabel, valueLabel, bottomFill].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [keyLabel, valueLabel].forEach { $0.textColor = .OVLWhite }

        keyLabel.numberOfLines = 0
        valueLabel.numberOfLines = 0
        backgroundColor = .OVLGray
        selectionStyle = .none
        
        if #available(iOSApplicationExtension 8.2, *) {
            keyLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        } else {
            keyLabel.font = UIFont.systemFont(ofSize: 18)
        }
        
        bottomFill.backgroundColor = .OVLDarkBlue
        bottomFill.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                keyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

                valueLabel.topAnchor.constraint(equalTo: keyLabel.bottomAnchor, constant: 8),
                valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                valueLabel.bottomAnchor.constraint(equalTo: bottomFill.topAnchor, constant: -16),
                
                bottomFill.heightAnchor.constraint(equalToConstant: 16),
                bottomFill.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bottomFill.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomFill.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "keyLabel": keyLabel,
                "valueLabel": valueLabel,
                "bottomFill": bottomFill
            ]
            
            let keyLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[keyLabel]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += keyLabelHorizontalPositionConstraint
            
            let valueLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[valueLabel]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += valueLabelHorizontalPositionConstraint
            
            let bottomFillHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[bottomFill]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += bottomFillHorizontalPositionConstraint
            
            let valueLabelVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-16-[keyLabel]-8-[valueLabel]-16-[bottomFill(16)]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            
            allConstraints += valueLabelVerticalPositionConstraint
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }
}
