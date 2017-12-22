//
//  TrafficDetailsView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class TrafficDetailsView: View {
    internal let segmentedControl = OVLSegmentedControl(frame: .zero)
    internal var contentView = UIView(frame: .zero)

    override func setupHierarchy() {
        [segmentedControl, contentView].forEach { addSubview($0) }
    }

    override func setupProperties() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .OVLDarkBlue
        self.backgroundColor = .OVLDarkBlue

        segmentedControl.insertSegment(withTitle: "Request".localized, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Response".localized, at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "contentView": contentView
            ]
            
            let verticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[contentView]-0-|",
                options: [.alignAllCenterX],
                metrics: nil,
                views: views
            )
            allConstraints += verticalPositionConstraint
            
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
