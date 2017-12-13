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
        }
    }
}
