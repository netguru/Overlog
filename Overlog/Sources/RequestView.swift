//
//  RequestView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class RequestView: View {

    let methodLabel = UILabel(frame: .zero)
    let urlLabel = UILabel(frame: .zero)
    let headersLabel = UILabel(frame: .zero)
    let deserializedBodyLabel = UILabel(frame: .zero)

    internal override func setupHierarchy() {
        [methodLabel, urlLabel, headersLabel, deserializedBodyLabel].forEach { addSubview($0) }
    }

    internal override func setupProperties() {
        [methodLabel, urlLabel, headersLabel, deserializedBodyLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        methodLabel.textColor = .white
        methodLabel.layer.cornerRadius = 4
        methodLabel.clipsToBounds = true
        methodLabel.textAlignment = .center

        methodLabel.backgroundColor = UIColor.blue

        headersLabel.numberOfLines = 0
        deserializedBodyLabel.numberOfLines = 0
    }

    internal override func setupConstraints() {

        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                methodLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                methodLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),

                urlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                urlLabel.topAnchor.constraint(equalTo: methodLabel.bottomAnchor, constant: 16),

                headersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                headersLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 16),

                deserializedBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                deserializedBodyLabel.topAnchor.constraint(equalTo: headersLabel.bottomAnchor, constant: 16),
            ])
        }
    }
}
