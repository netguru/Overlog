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
    internal let indicatorImageView = UIImageView(image: .init(namedInOverlogBundle: "button-details"))
    internal let borderView = UILabel(frame: .zero)

    override func setupHierarchy() {
        [nameLabel, indicatorImageView, counterLabel, borderView].forEach { contentView.addSubview($0) }
    }

    override func setupProperties() {
        [nameLabel, indicatorImageView, counterLabel, borderView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [nameLabel, counterLabel].forEach { $0.textColor = .OVLWhite }

        backgroundColor = .OVLDarkBlue
        accessoryType = .none
        selectionStyle = .default
        
        nameLabel.font = .OVLFont(ofSize: 18, weight: .semibold)
        
        counterLabel.layer.cornerRadius = 6
        counterLabel.textAlignment = .center
        counterLabel.clipsToBounds = true
        
        borderView.backgroundColor = .OVLGray
    }

    override func setupConstraints() {
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
                nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

                counterLabel.trailingAnchor.constraint(equalTo: indicatorImageView.leadingAnchor, constant: -4),
                counterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                counterLabel.widthAnchor.constraint(equalToConstant: 24),
                
                indicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
                indicatorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                indicatorImageView.widthAnchor.constraint(equalToConstant: 24),
                indicatorImageView.heightAnchor.constraint(equalToConstant: 24),
                
                borderView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: indicatorImageView.trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: 1)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "nameLabel": nameLabel,
                "counterLabel": counterLabel,
                "indicatorImageView": indicatorImageView,
                "borderView": borderView
            ]
            
            let horizontalViewsPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-32-[nameLabel]-4-[counterLabel(24)]",
                options: [.alignAllCenterY],
                metrics: nil,
                views: views
            )
            allConstraints += horizontalViewsPositionConstraint
            
            let verticalViewsPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-20-[nameLabel]-20-[borderView(1)]-0-|",
                options: [.alignAllCenterX],
                metrics: nil,
                views: views
            )
            allConstraints += verticalViewsPositionConstraint
            
            let indicatorImageHorizontalConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "[indicatorImageView(24)]-32-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += indicatorImageHorizontalConstraint
            
            let indicatorImageViewHeightConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:[indicatorImageView(24)]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += indicatorImageViewHeightConstraint
            
            let indicatorImageCenterConstraint = [
                NSLayoutConstraint.init(
                    item: indicatorImageView,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: contentView,
                    attribute: .centerY,
                    multiplier: 1,
                    constant: 0
                )
            ]
            allConstraints += indicatorImageCenterConstraint
            
            let borderViewConstraint = [
                NSLayoutConstraint.init(
                    item: borderView,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: nameLabel,
                    attribute: .leading,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: borderView,
                    attribute: .trailing,
                    relatedBy: .equal,
                    toItem: indicatorImageView,
                    attribute: .trailing,
                    multiplier: 1,
                    constant: 0
                )
            ]
            allConstraints += borderViewConstraint
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? .OVLGray : .clear
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? .OVLGray : .clear
    }
    
    /// Hides bottom border
    internal func hideBorder() {
        borderView.backgroundColor = .clear
    }
}
