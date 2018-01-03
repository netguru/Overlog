//
//  RequestView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class RequestView: View {

    private let scrollView = UIScrollView(frame: .zero)
    internal let urlView = KeyValueView(title: "URL".localized)
    internal let methodView = KeyValueView(title: "Method".localized)
    internal let headersView = KeyValueView(title: "Headers".localized)
    internal let bodyView = KeyValueView(title: "Body".localized)

    internal override func setupHierarchy() {
        addSubview(scrollView)
        [urlView, methodView, headersView, bodyView].forEach { scrollView.addSubview($0) }
    }

    internal override func setupProperties() {
        [scrollView, urlView, methodView, headersView, bodyView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        backgroundColor = .OVLDarkBlue
    }

    internal override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

                urlView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                urlView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                urlView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),

                methodView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                methodView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                methodView.topAnchor.constraint(equalTo: urlView.bottomAnchor, constant: 16),
                
                headersView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                headersView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                headersView.topAnchor.constraint(equalTo: methodView.bottomAnchor, constant: 16),

                bodyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                bodyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                bodyView.topAnchor.constraint(equalTo: headersView.bottomAnchor, constant: 16),
                bodyView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()

            let views = [
                "scrollView": scrollView,
                "urlView": urlView,
                "methodView": methodView,
                "headersView": headersView,
                "bodyView": bodyView
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
                withVisualFormat: "V:|-16-[urlView]-16-[methodView]-16-[headersView]-16-[bodyView]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += verticalPositionConstraint

            let urlViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[urlView]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += urlViewHorizontalPositionConstraint

            let methodViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[methodView]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += methodViewHorizontalPositionConstraint
            
            let headersViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[headersView]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += headersViewHorizontalPositionConstraint
            
            let bodyViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[bodyView]-0-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += bodyViewHorizontalPositionConstraint

            NSLayoutConstraint.activate(allConstraints)
        }
    }
}
