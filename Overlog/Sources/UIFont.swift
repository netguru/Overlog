//
//  UIFont.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal extension UIFont {
    
    /// Weight of the font
    ///
    /// - regular: Regular weight
    /// - semibold: Semibold weight
    /// - bold: Bold weight
    internal enum OVLWeight {
        case regular
        case semibold
        case bold
    }
    
    /// Method for getting default application font. Works with all supported iOS versions.
    ///
    /// - Parameters:
    ///   - size: Size of the font
    ///   - weight: Weight of the font
    /// - Returns: Font to use
    internal class func OVLFont(ofSize size: CGFloat, weight: OVLWeight) -> UIFont {
        if #available(iOSApplicationExtension 8.2, *) {
            return .systemFont(ofSize: size, weight: fontWeight(fromOVLWeight: weight))
        } else {
            return UIFont(name: "HelveticaNeue\(rawTextValue(forWeight: weight))", size: size)!
        }
    }
    
    /// Helper method for creating Font on iOS >= 8.2
    ///
    /// - Parameter weight: Weight of the font
    /// - Returns: System weight value
    private class func fontWeight(fromOVLWeight weight: OVLWeight) -> UIFontWeight {
        if #available(iOSApplicationExtension 8.2, *) {
            switch weight {
            case .regular:
                return UIFontWeightRegular
            case .semibold:
                return UIFontWeightSemibold
            case .bold:
                return UIFontWeightBold
            }
        }
        return 0
    }
    
    /// Helper method for creating Font on iOS < 8.2
    ///
    /// - Parameter weight: Weight of the font
    /// - Returns: Text that can be appened to font name
    private class func rawTextValue(forWeight weight: OVLWeight) -> String {
        switch weight {
        case .regular:
            return ""
        case .semibold:
            return "-Medium"
        case .bold:
            return "-Bold"
        }
    }

}
