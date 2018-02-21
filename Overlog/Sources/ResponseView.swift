//
//  ResponseView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class ResponseView: View {

    internal let scrollView = UIScrollView(frame: .zero)
    internal let statusView = StatusView(title: "Status".localized)
    internal let firstRow = KeyValueView(frame: .zero)
    internal let secondRow = KeyValueView(frame: .zero)
    internal let thirdRow = KeyValueView(frame: .zero)

    internal override func setupHierarchy() {
        addSubview(scrollView)
        [statusView, firstRow, secondRow, thirdRow].forEach { scrollView.addSubview($0) }
    }

    internal override func setupProperties() {
        [scrollView, statusView, firstRow, secondRow, thirdRow].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        backgroundColor = .OVLDarkBlue
        scrollView.indicatorStyle = .white
        scrollView.alwaysBounceVertical = true
    }

    internal override func setupConstraints() {
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                
                statusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                statusView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                statusView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
                
                firstRow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                firstRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                firstRow.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 16),
                
                secondRow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                secondRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                secondRow.topAnchor.constraint(equalTo: firstRow.bottomAnchor, constant: 16),
                
                thirdRow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                thirdRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                thirdRow.topAnchor.constraint(equalTo: secondRow.bottomAnchor, constant: 16),
                thirdRow.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()

            let views = [
                "scrollView": scrollView,
                "statusView": statusView,
                "firstRow": firstRow,
                "secondRow": secondRow,
                "thirdRow": thirdRow
            ]

            let scrollViewVerticalPosition = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[scrollView]-8-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += scrollViewVerticalPosition

            let scrollViewHorizontalPosition = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[scrollView]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += scrollViewHorizontalPosition

            let verticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-16-[statusView]-16-[firstRow]-16-[secondRow]-16-[thirdRow]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += verticalPositionConstraint

            let statusViewHorizontalConstraints = [
                NSLayoutConstraint.init(item: statusView, attribute: .leading, relatedBy: .equal,
                                        toItem: self, attribute: .leading,
                                        multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: statusView, attribute: .trailing, relatedBy: .equal,
                                        toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
            ]
            allConstraints += statusViewHorizontalConstraints
            
            let firstRowHorizontalConstraints = [
                NSLayoutConstraint.init(item: firstRow, attribute: .leading, relatedBy: .equal,
                                        toItem: self, attribute: .leading,
                                        multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: firstRow, attribute: .trailing, relatedBy: .equal,
                                        toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
            ]
            allConstraints += firstRowHorizontalConstraints
            
            
            let secondRowHorizontalConstraints = [
                NSLayoutConstraint.init(item: secondRow, attribute: .leading, relatedBy: .equal,
                                        toItem: self, attribute: .leading,
                                        multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: secondRow, attribute: .trailing, relatedBy: .equal,
                                        toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
            ]
            allConstraints += secondRowHorizontalConstraints
            
            let thirdRowHorizontalConstraints = [
                NSLayoutConstraint.init(item: thirdRow, attribute: .leading, relatedBy: .equal,
                                        toItem: self, attribute: .leading,
                                        multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: thirdRow, attribute: .trailing, relatedBy: .equal,
                                        toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
            ]
            allConstraints += thirdRowHorizontalConstraints

            NSLayoutConstraint.activate(allConstraints)
        }
    }
}
