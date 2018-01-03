//
//  UIColor.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal extension UIColor {
    
    class var OVLBlue: UIColor {
        return UIColor(hex: 0x2A79FF)
    }
    
    class var OVLDarkBlue: UIColor {
        return UIColor(hex: 0x0C1338)
    }
    
    class var OVLLightBlue: UIColor {
        return UIColor(hex: 0x3A8FFF)
    }
    
    class var OVLGray: UIColor {
        return UIColor(hex: 0x1D2447)
    }
    
    class var OVLLightGray: UIColor {
        return UIColor(hex: 0x686E92)
    }
    
    class var OVLWhite: UIColor {
        return UIColor(hex: 0xFFFFFF)
    }
    
    class var OVLStatusGreen: UIColor {
        return UIColor(hex: 0x3DC46F)
    }
    
    class var OVLStatusRed: UIColor {
        return UIColor(hex: 0xBC2F3B)
    }
    
    class var OVLStatusYellow: UIColor {
        return UIColor(hex: 0xF1D575)
    }
    
    /// Initializes and returns a color object using the specified RGB component values.
    ///
    /// - Parameter hex: The hex value of the color object.
    convenience init(hex: Int) {
        let red = CGFloat((hex >> 16) & 0xff) / 255
        let green = CGFloat((hex >> 08) & 0xff) / 255
        let blue = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
