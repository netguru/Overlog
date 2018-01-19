//
//  UIFont.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal extension UIFont {
    
    /// Type of the font
    ///
    /// - standard: Standard font
    /// - code: Code font
    internal enum OVLType {
        case standard
        case code
    }
    
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
    internal class func OVLFont(ofSize size: CGFloat, weight: OVLWeight, type: OVLType = .standard) -> UIFont {
        let font: UIFont?
            switch type {
            case .standard:
                if #available(iOS 8.2, *) {
                    font = .systemFont(ofSize: size, weight: fontWeight(fromOVLWeight: weight))
                } else {
                    font = UIFont(name: "HelveticaNeue\(rawTextValue(forWeight: weight))", size: size)
                }
            case .code:
                font = UIFont(name: "Menlo\(rawTextValue(forWeight: weight))", size: size)
            }
        return font ?? .systemFont(ofSize: size)
    }
    
    /// Helper method for creating Font on iOS >= 8.2
    ///
    /// - Parameter weight: Weight of the font
    /// - Returns: System weight value
    private class func fontWeight(fromOVLWeight weight: OVLWeight) -> UIFont.Weight {
        if #available(iOS 8.2, *) {
            switch weight {
            case .regular:
                return .regular
            case .semibold:
                return .semibold
            case .bold:
                return .bold
            }
        }
        return UIFont.Weight(rawValue: 0)
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
