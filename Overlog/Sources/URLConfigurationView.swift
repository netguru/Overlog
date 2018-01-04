//
//  URLConfigurationView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class URLConfigurationView: View {
    
    private let titleLabel = UILabel(frame: .zero)
    internal let inputField = UITextField(frame: .zero)
    internal let segmentedControl = UISegmentedControl(frame: .zero)
    
    internal override func setupHierarchy() {
        [titleLabel, inputField, segmentedControl].forEach { addSubview($0) }
    }
    
    internal override func setupProperties() {
        backgroundColor = .white
        [titleLabel, inputField, segmentedControl].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        titleLabel.text = "Host:"
        titleLabel.font = .OVLFont(ofSize: 16, weight: .bold)
        
        inputField.placeholder = "(e.g. foo.bar.co):"
        inputField.keyboardType = .URL
        inputField.autocapitalizationType = .none
        inputField.autocorrectionType = .no
    }
    
    internal override func setupConstraints() {
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
                segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 72),
                segmentedControl.widthAnchor.constraint(equalToConstant: 200),
                segmentedControl.heightAnchor.constraint(equalToConstant: 32),
                
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
                
                inputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                inputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                inputField.heightAnchor.constraint(equalToConstant: 44),
                inputField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            ])
        }
    }

    internal override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.beginPath()
        context.move(to: CGPoint(x: inputField.frame.minX, y: inputField.frame.maxY))
        context.addLine(to: CGPoint(x: inputField.frame.maxX, y: inputField.frame.maxY))
        context.setLineWidth(1)
        context.setStrokeColor(UIView().tintColor.cgColor)
        context.strokePath()
    }
}
