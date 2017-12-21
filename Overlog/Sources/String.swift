//
//  String.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
import UIKit

internal extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    /// Creates code styled attributed string
    ///
    /// - Parameter fontSize: Size of the font to calculate spacing
    /// - Returns: Code attributed string
    internal func codeAttributed(forFontSize fontSize: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0.2 * fontSize
        return NSAttributedString(string: self, attributes: [NSParagraphStyleAttributeName: paragraphStyle])
    }
    
}
