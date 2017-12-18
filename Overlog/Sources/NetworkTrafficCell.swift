//
//  NetworkTrafficCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class NetworkTrafficCell: TableViewCell {

    internal let requestTypeLabel = UILabel(frame: .zero)
    internal let requestURLLabel = UILabel(frame: .zero)
    internal let indicatorImageView = UIImageView(image: .init(namedInOverlogBundle: "details-default"))
    internal let bottomFill = UIView(frame: .zero)

    internal override func setupHierarchy() {
        [requestTypeLabel, requestURLLabel, bottomFill, indicatorImageView].forEach { contentView.addSubview($0) }
    }

    internal override func setupProperties() {
        [requestTypeLabel, requestURLLabel, bottomFill, indicatorImageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        accessoryType = .none
        
        requestTypeLabel.textColor = .OVLWhite
        requestTypeLabel.layer.cornerRadius = 4
        requestTypeLabel.clipsToBounds = true
        requestTypeLabel.textAlignment = .center
        requestTypeLabel.backgroundColor = .OVLDarkBlue
        
        requestURLLabel.textColor = .OVLWhite
        
        bottomFill.backgroundColor = .OVLDarkBlue
        bottomFill.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
    }

    internal override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                requestTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                requestTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                requestTypeLabel.widthAnchor.constraint(equalToConstant: 96),

                requestURLLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                requestURLLabel.topAnchor.constraint(equalTo: requestTypeLabel.bottomAnchor, constant: 16),
                requestURLLabel.bottomAnchor.constraint(equalTo: bottomFill.topAnchor, constant: -16),
                
                indicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                indicatorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -8),
                indicatorImageView.widthAnchor.constraint(equalToConstant: 8),
                indicatorImageView.heightAnchor.constraint(equalToConstant: 13),
                
                bottomFill.heightAnchor.constraint(equalToConstant: 16),
                bottomFill.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bottomFill.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomFill.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "requestTypeLabel": requestTypeLabel,
                "requestURLLabel": requestURLLabel,
                "indicatorImageView": indicatorImageView,
                "bottomFill": bottomFill
            ]
            
            let requestTypeLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[requestTypeLabel(96)]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += requestTypeLabelHorizontalPositionConstraint
            
            let requestURLLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[requestURLLabel]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += requestURLLabelHorizontalPositionConstraint
            
            let bottomFillHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[bottomFill]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += bottomFillHorizontalPositionConstraint
            
            let leftViewsVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-16-[requestTypeLabel]-16-[requestURLLabel]-16-[bottomFill(16)]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += leftViewsVerticalPositionConstraint
            
            let indicatorHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:[indicatorImageView(8)]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += indicatorHorizontalPositionConstraint
            
            let indicatorVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:[indicatorImageView(13)]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += indicatorVerticalPositionConstraint
            
            let indicatorCenterConstraint = [
                NSLayoutConstraint.init(
                    item: indicatorImageView,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: contentView,
                    attribute: .centerY,
                    multiplier: 1,
                    constant: -8
                )
            ]
            allConstraints += indicatorCenterConstraint

            NSLayoutConstraint.activate(allConstraints)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? .OVLLightGray : .OVLGray
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? .OVLLightGray : .OVLGray
    }
}
