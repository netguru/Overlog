//
//  OVLSegmentedControl.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

class OVLSegmentedControl: UISegmentedControl {
    
    /// Initialize the receiver
    ///
    /// - Parameter frame: frame to be used.
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupProperties()
    }
    
    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProperties() {
        tintColor = .OVLBlue
        backgroundColor = .OVLGray
        setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.OVLWhite], for: .normal)
        setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.OVLWhite], for: .selected)
        setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.OVLWhite.withAlphaComponent(0.25)], for: .disabled)
    }

}
