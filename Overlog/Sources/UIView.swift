//
//  UIView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal extension UIView {
    
    /// Disables translating autoresazing mask into constraints and pins the view edges to its superview edges using AutoLayout
    internal func pinToSuperviewEdges() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                topAnchor.constraint(equalTo: superview.topAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
        } else {
            let constraints = [
                NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal,
                                        toItem: superview, attribute: .leading,
                                        multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal,
                                        toItem: superview, attribute: .trailing,
                                        multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal,
                                        toItem: superview, attribute: .top,
                                        multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal,
                                        toItem: superview, attribute: .bottom,
                                        multiplier: 1, constant: 0),
            ]
            NSLayoutConstraint.activate(constraints)
        }
    }
}
