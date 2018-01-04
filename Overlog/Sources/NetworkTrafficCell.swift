//
//  NetworkTrafficCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class NetworkTrafficCell: TableViewCell {

    internal let requestLabel = UILabel(frame: .zero)
    internal let requestStatusLabel = UILabel(frame: .zero)
    internal let indicatorImageView = UIImageView(image: .init(namedInOverlogBundle: "details"))
    internal let statusCircle = UIView(frame: .zero)
    internal let bottomBorder = UIView(frame: .zero)
    
    /// Setups the cell with given traffic entry
    ///
    /// - Parameter entry: Traffic entry to setup the cell
    internal func setup(withEntry entry: NetworkTrafficEntry) {
        if entry.isInProgress {
            requestStatusLabel.text = "IN PROGRESS...".localized
            statusCircle.backgroundColor = .OVLStatusYellow
        } else {
            requestStatusLabel.text = entry.statusCodeWithTextRepresentation.uppercased()
            statusCircle.backgroundColor = entry.responsedWithSuccess ? .OVLStatusGreen : .OVLStatusRed
        }
        requestLabel.text = entry.request.method.uppercased() + " " + entry.hostWithPath
    }

    internal override func setupHierarchy() {
        [requestLabel, requestStatusLabel, bottomBorder, indicatorImageView, statusCircle].forEach { contentView.addSubview($0) }
    }

    internal override func setupProperties() {
        [requestLabel, requestStatusLabel, bottomBorder, indicatorImageView, statusCircle].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [requestLabel, requestStatusLabel].forEach { $0.textColor = .OVLWhite}
        
        accessoryType = .none
        
        requestLabel.numberOfLines = 0
        requestLabel.font = UIFont.OVLFont(ofSize: 16, weight: .bold, type: .code)
        requestStatusLabel.font = UIFont.OVLFont(ofSize: 14, weight: .regular, type: .code)
        
        statusCircle.backgroundColor = .white
        statusCircle.layer.cornerRadius = 4
        
        bottomBorder.backgroundColor = .OVLGray
        bottomBorder.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
    }

    internal override func setupConstraints() {
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                requestLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                requestLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                requestLabel.trailingAnchor.constraint(equalTo: indicatorImageView.leadingAnchor, constant: -8),

                statusCircle.centerYAnchor.constraint(equalTo: requestStatusLabel.centerYAnchor, constant: 0),
                statusCircle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                statusCircle.widthAnchor.constraint(equalToConstant: 8),
                statusCircle.heightAnchor.constraint(equalToConstant: 8),
                
                requestStatusLabel.leadingAnchor.constraint(equalTo: statusCircle.trailingAnchor, constant: 8),
                requestStatusLabel.topAnchor.constraint(equalTo: requestLabel.bottomAnchor, constant: 8),
                requestStatusLabel.bottomAnchor.constraint(equalTo: bottomBorder.topAnchor, constant: -16),
                requestStatusLabel.trailingAnchor.constraint(equalTo: indicatorImageView.leadingAnchor, constant: -8),
                
                indicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                indicatorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
                indicatorImageView.widthAnchor.constraint(equalToConstant: 24),
                indicatorImageView.heightAnchor.constraint(equalToConstant: 24),
                
                bottomBorder.heightAnchor.constraint(equalToConstant: 1),
                bottomBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bottomBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "requestLabel": requestLabel,
                "requestStatusLabel": requestStatusLabel,
                "statusCircle": statusCircle,
                "indicatorImageView": indicatorImageView,
                "bottomBorder": bottomBorder
            ]
            
            let requestLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[requestLabel]-8-[indicatorImageView(24)]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += requestLabelHorizontalPositionConstraint
            
            let requestStatusLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[statusCircle(8)]-8-[requestStatusLabel]-8-[indicatorImageView]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += requestStatusLabelHorizontalPositionConstraint
            
            let bottomFillHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[bottomBorder]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += bottomFillHorizontalPositionConstraint
            
            let leftViewsVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-16-[requestLabel]-8-[requestStatusLabel]-16-[bottomBorder(1)]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += leftViewsVerticalPositionConstraint
            
            let indicatorVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:[indicatorImageView(24)]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += indicatorVerticalPositionConstraint
            
            let statusCircleVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:[statusCircle(8)]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += statusCircleVerticalPositionConstraint
            
            let indicatorCenterConstraint = [
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
            allConstraints += indicatorCenterConstraint
            
            let statusCircleCenterConstraint = [
                NSLayoutConstraint.init(
                    item: statusCircle,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: requestStatusLabel,
                    attribute: .centerY,
                    multiplier: 1,
                    constant: 0
                )
            ]
            allConstraints += statusCircleCenterConstraint

            NSLayoutConstraint.activate(allConstraints)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? .OVLGray : .OVLDarkBlue
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? .OVLGray : .OVLDarkBlue
    }
}
