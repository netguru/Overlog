//
//  UIImage.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal extension UIImage {
    
    convenience init(namedInOverlogBundle: String) {
        self.init(named: namedInOverlogBundle, in: Bundle(for: Overlog.self), compatibleWith: nil)!
    }
}
