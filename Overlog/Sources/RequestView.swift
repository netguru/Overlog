//
//  RequestView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class RequestView: View {

    fileprivate let scrollView = UIScrollView(frame: .zero)
    internal let methodLabel = UILabel(frame: .zero)
    internal let urlLabel = UILabel(frame: .zero)
    internal let headersLabel = UILabel(frame: .zero)
    internal let deserializedBodyLabel = UILabel(frame: .zero)

    internal override func setupHierarchy() {
        addSubview(scrollView)
        [methodLabel, urlLabel, headersLabel, deserializedBodyLabel].forEach { scrollView.addSubview($0) }
    }

    internal override func setupProperties() {
        [scrollView, methodLabel, urlLabel, headersLabel, deserializedBodyLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }


        methodLabel.textColor = .white
        methodLabel.layer.cornerRadius = 4
        methodLabel.clipsToBounds = true
        methodLabel.textAlignment = .center

        methodLabel.backgroundColor = UIColor.blue

        urlLabel.numberOfLines = 0
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

                methodLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                methodLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),

                urlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                urlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
                urlLabel.topAnchor.constraint(equalTo: methodLabel.bottomAnchor, constant: 16),

                headersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                headersLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 16),

                deserializedBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                deserializedBodyLabel.topAnchor.constraint(equalTo: headersLabel.bottomAnchor, constant: 16),
                deserializedBodyLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        }
    }
}
