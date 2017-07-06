//
//  ResponseView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class ResponseView: View {
    let statusCodeLabel = UILabel(frame: .zero)
    let urlLabel = UILabel(frame: .zero)
    let headersLabel = UILabel(frame: .zero)
    let deserializedBodyLabel = UILabel(frame: .zero)

    internal override func setupHierarchy() {
        [statusCodeLabel, urlLabel, headersLabel, deserializedBodyLabel].forEach { addSubview($0) }
    }

    internal override func setupProperties() {
        [statusCodeLabel, urlLabel, headersLabel, deserializedBodyLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        statusCodeLabel.textColor = .white
        statusCodeLabel.layer.cornerRadius = 4
        statusCodeLabel.clipsToBounds = true
        statusCodeLabel.textAlignment = .center

        statusCodeLabel.backgroundColor = UIColor.blue

        headersLabel.numberOfLines = 0
        deserializedBodyLabel.numberOfLines = 0
    }

    internal override func setupConstraints() {

        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                statusCodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                statusCodeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),

                urlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                urlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
                urlLabel.topAnchor.constraint(equalTo: statusCodeLabel.bottomAnchor, constant: 16),

                headersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                headersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
                headersLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 16),

                deserializedBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                deserializedBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
                deserializedBodyLabel.topAnchor.constraint(equalTo: headersLabel.bottomAnchor, constant: 16),
            ])
        }
    }
}
