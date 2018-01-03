//
//  KeyValueView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class KeyValueView: View {
    
    internal let keyLabel = UILabel(frame: .zero)
    internal let valueLabel = UILabel(frame: .zero)
    
    convenience init(title: String?) {
        self.init(frame: .zero)
        keyLabel.text = title
    }
    
    override func setupHierarchy() {
        [keyLabel, valueLabel].forEach { addSubview($0) }
    }
    
    override func setupProperties() {
        [keyLabel, valueLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textColor = .OVLWhite
            $0.numberOfLines = 0
        }
        backgroundColor = .OVLGray
        keyLabel.font = .OVLFont(ofSize: 16, weight: .bold, type: .code)
        valueLabel.font = .OVLFont(ofSize: 14, weight: .regular, type: .code)
    }
    
    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                keyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                keyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                keyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                
                valueLabel.topAnchor.constraint(equalTo: keyLabel.bottomAnchor, constant: 8),
                valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "keyLabel": keyLabel,
                "valueLabel": valueLabel,
            ]
            
            let keyLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[keyLabel]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += keyLabelHorizontalPositionConstraint
            
            let valueLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[valueLabel]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += valueLabelHorizontalPositionConstraint
            
            let valueLabelVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-16-[keyLabel]-8-[valueLabel]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += valueLabelVerticalPositionConstraint
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }
}
