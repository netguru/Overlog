//
//  NetworkTrafficCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class NetworkTrafficCell: TableViewCell {

    internal let requestTypeLabel = UILabel(frame: .zero)
    internal let requestURLLabel = UILabel(frame: .zero)
    internal let indicatorImageView = UIImageView(image: .init(namedInOverlogBundle: "details-default"))
    internal let bottomFill = UIView(frame: .zero)

    internal override func setupHierarchy() {
        [requestTypeLabel, requestURLLabel, bottomFill, indicatorImageView].forEach { contentView.addSubview($0) }
    }

    internal override func setupProperties() {
        [requestTypeLabel, requestURLLabel, bottomFill, indicatorImageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        accessoryType = .none
        
        requestTypeLabel.textColor = .OVLWhite
        requestTypeLabel.layer.cornerRadius = 4
        requestTypeLabel.clipsToBounds = true
        requestTypeLabel.textAlignment = .center
        requestTypeLabel.backgroundColor = .OVLDarkBlue
        
        requestURLLabel.textColor = .OVLWhite
        
        bottomFill.backgroundColor = .OVLDarkBlue
        bottomFill.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
    }

    internal override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                requestTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                requestTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                requestTypeLabel.widthAnchor.constraint(equalToConstant: 96),

                requestURLLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                requestURLLabel.topAnchor.constraint(equalTo: requestTypeLabel.bottomAnchor, constant: 16),
                requestURLLabel.bottomAnchor.constraint(equalTo: bottomFill.topAnchor, constant: -16),
                
                indicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                indicatorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -8),
                indicatorImageView.widthAnchor.constraint(equalToConstant: 8),
                indicatorImageView.heightAnchor.constraint(equalToConstant: 13),
                
                bottomFill.heightAnchor.constraint(equalToConstant: 16),
                bottomFill.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bottomFill.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomFill.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? .OVLLightGray : .OVLGray
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? .OVLLightGray : .OVLGray
    }
}
