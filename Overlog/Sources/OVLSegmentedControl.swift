//
//  OVLSegmentedControl.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class OVLSegmentedControl: UISegmentedControl {
    
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
        clipsToBounds = true
        layer.cornerRadius = 6
        tintColor = .OVLBlue
        backgroundColor = .OVLGray
        removeBorders()
        setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.OVLFont(ofSize: 14, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.OVLWhite
            ], for: .normal)
        
        setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.OVLFont(ofSize: 14, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.OVLWhite
            ], for: .selected)
        
        setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.OVLFont(ofSize: 14, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.OVLWhite.withAlphaComponent(0.25)
            ], for: .disabled)
    }
    
    /// Methods that removes default borders from segmented control
    private func removeBorders() {
        guard let backgroundColor = backgroundColor, let tintColor = tintColor else { return }
        setBackgroundImage(image(withColor: backgroundColor), for: .normal, barMetrics: .default)
        setBackgroundImage(image(withColor: tintColor), for: .selected, barMetrics: .default)
        setDividerImage(image(withColor: .clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    /// Creates a 1x1 image with given color
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
