//
//  UINavigationBar.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
import UIKit.UINavigationBar

internal extension UINavigationBar {
    
    internal class func loadBackAppearance() {
        let rawBackImage = UIImage(namedInOverlogBundle: "navigationBackArrow")
        
        /// Adding left inset to the back image
        ///
        /// Workaround for iOS < 9
        /// Can't use image with pre-added insets because of bug with distorted image.
        /// When creating new image with inset everything works.
        let horizontalInset: CGFloat = 10
        UIGraphicsBeginImageContextWithOptions(.init(width: rawBackImage.size.width + horizontalInset, height: rawBackImage.size.height), false, 0)
        rawBackImage.draw(at: .init(x: horizontalInset, y: 0))
        let backImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
    }
}

