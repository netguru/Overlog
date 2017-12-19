//
//  TrafficDetailsView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class TrafficDetailsView: View {
    internal let segmentedControl = UISegmentedControl(frame: .zero)
    internal var contentView = UIView(frame: .zero)

    override func setupHierarchy() {
        [segmentedControl, contentView].forEach { addSubview($0) }
    }

    override func setupProperties() {
        contentView.backgroundColor = .OVLDarkBlue
        self.backgroundColor = .OVLDarkBlue
        
        segmentedControl.tintColor = .OVLWhite

        [contentView, segmentedControl].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        segmentedControl.insertSegment(withTitle: "Request".localized, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Response", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                segmentedControl.topAnchor.constraint(equalTo: topAnchor),
                segmentedControl.widthAnchor.constraint(equalToConstant: 200),
                segmentedControl.heightAnchor.constraint(equalToConstant: 32),
                segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),

                contentView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "segmentedControl": segmentedControl,
                "contentView": contentView
            ]
            
            let verticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[segmentedControl(32)]-16-[contentView]-0-|",
                options: [.alignAllCenterX],
                metrics: nil,
                views: views
            )
            allConstraints += verticalPositionConstraint
            
            let segmentedControlHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:[segmentedControl(200)]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += segmentedControlHorizontalPositionConstraint
            
            let contentViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[contentView]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += contentViewHorizontalPositionConstraint
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }

}
