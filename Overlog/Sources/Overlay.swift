//
// Overlay.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public final class Overlay {
    
    public let window: UIWindow
    
    fileprivate let rootViewController: OverlayViewController
    
    public init(frame: CGRect) {
        window = UIWindow(frame: frame)
        rootViewController = OverlayViewController()
        window.rootViewController = rootViewController
        
        window.windowLevel = UIWindowLevelAlert
        window.makeKeyAndVisible()
    }
    
}
