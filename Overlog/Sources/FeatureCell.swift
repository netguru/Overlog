//
//  FeatureCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

final class FeatureCell: TableViewCell {

    internal let nameLabel = UILabel(frame: .zero)
    internal let counterLabel = UILabel(frame: .zero)
    internal let indicatorImageView = UIImageView(image: .init(namedInOverlogBundle: "details"))
    internal let borderView = UILabel(frame: .zero)

    override func setupHierarchy() {
        [nameLabel, indicatorImageView, counterLabel, borderView].forEach { contentView.addSubview($0) }
    }

    override func setupProperties() {
        [nameLabel, indicatorImageView, counterLabel, borderView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [nameLabel, counterLabel].forEach { $0.textColor = .OVLWhite }

        backgroundColor = .OVLDarkBlue
        accessoryType = .none
        selectionStyle = .default
        
        if #available(iOSApplicationExtension 8.2, *) {
            nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
        } else {
            nameLabel.font = UIFont.systemFont(ofSize: 18)
        }
        
        counterLabel.layer.cornerRadius = 6
        counterLabel.textAlignment = .center
        counterLabel.clipsToBounds = true
        
        borderView.backgroundColor = .OVLGray
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
                nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

                counterLabel.trailingAnchor.constraint(equalTo: indicatorImageView.leadingAnchor, constant: -4),
                counterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                counterLabel.widthAnchor.constraint(equalToConstant: 24),
                
                indicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
                indicatorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                indicatorImageView.widthAnchor.constraint(equalToConstant: 30),
                indicatorImageView.heightAnchor.constraint(equalToConstant: 30),
                
                borderView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: indicatorImageView.trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: 1)
            ])
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? .OVLGray : .clear
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? .OVLGray : .clear
    }
    
    /// Hides bottom border
    internal func hideBorder() {
        borderView.backgroundColor = .clear
    }
}
