//
//  StatusView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class StatusView: View {
    
    private let keyLabel = UILabel(frame: .zero)
    internal let valueBackground = UILabel(frame: .zero)
    internal let valueLabel = UILabel(frame: .zero)
    
    convenience init(title: String?) {
        self.init(frame: .zero)
        keyLabel.text = title
    }
    
    override func setupHierarchy() {
        valueBackground.addSubview(valueLabel)
        [keyLabel, valueBackground].forEach { addSubview($0) }
    }
    
    override func setupProperties() {
        [keyLabel, valueBackground, valueLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [keyLabel, valueLabel].forEach { $0.textColor = .OVLWhite }
        
        backgroundColor = .OVLGray
        keyLabel.numberOfLines = 0
        valueLabel.numberOfLines = 1
        valueLabel.textAlignment = .center
        valueBackground.layer.cornerRadius = 6
        valueBackground.clipsToBounds = true
        
        keyLabel.font = .OVLFont(ofSize: 16, weight: .bold, type: .code)
        valueLabel.font = .OVLFont(ofSize: 14, weight: .regular, type: .code)
    }
    
    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                keyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                keyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                keyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                
                valueBackground.topAnchor.constraint(equalTo: keyLabel.bottomAnchor, constant: 8),
                valueBackground.heightAnchor.constraint(equalToConstant: 26),
                valueBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                valueBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                
                valueLabel.centerYAnchor.constraint(equalTo: valueBackground.centerYAnchor),
                valueLabel.leadingAnchor.constraint(equalTo: valueBackground.leadingAnchor, constant: 8),
                valueLabel.trailingAnchor.constraint(equalTo: valueBackground.trailingAnchor, constant: -8),
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "keyLabel": keyLabel,
                "valueLabel": valueLabel,
                "valueBackground": valueBackground,
            ]
            
            let keyLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[keyLabel]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += keyLabelHorizontalPositionConstraint
            
            let valueLabelHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[valueBackground]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += valueLabelHorizontalPositionConstraint
            
            let valueLabelVerticalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-16-[keyLabel]-8-[valueBackground(26)]-16-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += valueLabelVerticalPositionConstraint
            
            let valueLabelMarginsConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-8-[valueLabel]-8-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += valueLabelMarginsConstraint
            
            let valueCenterYConstraint = [
                NSLayoutConstraint.init(
                    item: valueLabel,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: valueBackground,
                    attribute: .centerY,
                    multiplier: 1,
                    constant: 0
                )
            ]
            allConstraints += valueCenterYConstraint
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }
}
