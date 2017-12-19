//
//  ResponseView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class ResponseView: View {

    internal let scrollView = UIScrollView(frame: .zero)
    internal let statusCodeLabel = UILabel(frame: .zero)
    internal let urlLabel = UILabel(frame: .zero)
    internal let headersLabel = UILabel(frame: .zero)
    internal let deserializedBodyLabel = UILabel(frame: .zero)

    internal override func setupHierarchy() {
        addSubview(scrollView)
        [statusCodeLabel, urlLabel, headersLabel, deserializedBodyLabel].forEach { scrollView.addSubview($0) }
    }

    internal override func setupProperties() {
        [scrollView, statusCodeLabel, urlLabel, headersLabel, deserializedBodyLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [urlLabel, headersLabel, deserializedBodyLabel, statusCodeLabel].forEach { $0.textColor = .OVLWhite }

        backgroundColor = .OVLGray
        
        statusCodeLabel.layer.cornerRadius = 4
        statusCodeLabel.clipsToBounds = true
        statusCodeLabel.textAlignment = .center
        statusCodeLabel.backgroundColor = UIColor.OVLDarkBlue

        headersLabel.numberOfLines = 0
        deserializedBodyLabel.numberOfLines = 0
    }

    internal override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

                statusCodeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                statusCodeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),

                urlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                urlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                urlLabel.topAnchor.constraint(equalTo: statusCodeLabel.bottomAnchor, constant: 16),

                headersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                headersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                headersLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 16),

                deserializedBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                deserializedBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                deserializedBodyLabel.topAnchor.constraint(equalTo: headersLabel.bottomAnchor, constant: 16),
                deserializedBodyLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "self": self,
                "scrollView": scrollView,
                "statusCodeLabel": statusCodeLabel,
                "urlLabel": urlLabel,
                "headersLabel": headersLabel,
                "deserializedBodyLabel": deserializedBodyLabel
            ]
            
            let scrollViewVerticalPosition = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-16-[scrollView]-8-|",
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
                withVisualFormat: "V:|-16-[statusCodeLabel]-16-[urlLabel]-16-[headersLabel]-16-[deserializedBodyLabel]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += verticalPositionConstraint
            
            let statusCodeLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[statusCodeLabel]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += statusCodeLabelHorizontalPositionConstraint
            
            let urlLabelHorizontalPositionConstraint = [
                NSLayoutConstraint.init(
                    item: urlLabel,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .leading,
                    multiplier: 1,
                    constant: 16
                ),
                NSLayoutConstraint.init(
                    item: urlLabel,
                    attribute: .trailing,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .trailing,
                    multiplier: 1,
                    constant: -16
                )
            ]
            allConstraints += urlLabelHorizontalPositionConstraint
            
            let headersLabelHorizontalPositionConstraint = [
                NSLayoutConstraint.init(
                    item: headersLabel,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .leading,
                    multiplier: 1,
                    constant: 16
                ),
                NSLayoutConstraint.init(
                    item: headersLabel,
                    attribute: .trailing,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .trailing,
                    multiplier: 1,
                    constant: -16
                )
            ]
            allConstraints += headersLabelHorizontalPositionConstraint
            
            let deserializedBodyLabelHorizontalPositionConstraint = [
                NSLayoutConstraint.init(
                    item: deserializedBodyLabel,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .leading,
                    multiplier: 1,
                    constant: 16
                ),
                NSLayoutConstraint.init(
                    item: deserializedBodyLabel,
                    attribute: .trailing,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .trailing,
                    multiplier: 1,
                    constant: -16
                )
            ]
            allConstraints += deserializedBodyLabelHorizontalPositionConstraint
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }
}
