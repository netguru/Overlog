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
        let backImage = UIImage(namedInOverlogBundle: "navigationBackArrow")
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
    }
}

