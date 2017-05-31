//
// OverlayViewController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class OverlayViewController: UIViewController {
    
    /// Handler of `.touchUpInside` action on `OverlayView.floatingButton`
    internal var didTapFloatingButton: ((UIButton) -> Void)? = nil
    
    /// Handler of `.motionShake` motion event
    internal var didPerformShakeEvent: ((UIEvent?) -> Void)? = nil
    
    /// Overlay view
    internal let overlayView = OverlayView()
    
    /// Overlay's child view controller
    internal let childViewController: UIViewController
    
    /// Initializes overlay with its child view controller
    ///
    /// - Parameter childViewController: A child view controller to be embedded
    internal init(childViewController: UIViewController) {
        self.childViewController = childViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func loadView() {
        view = overlayView
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.floatingButton.addTarget(
            self,
            action: #selector(didTapFloatingButton(button:)),
            for: .touchUpInside
        )
        
        addChildViewController(childViewController)
        overlayView.embed(view: childViewController.view)
        childViewController.didMove(toParentViewController: self)
    }
        
    /// Overrides super method and calls `didPerformShakeEvent` closure when `.motionShake` was recevied. 
    /// Please refer to super method documentation for further information.
    ///
    /// - Parameters:
    ///   - motion: `UIEventSubtype`
    ///   - event: `UIEvent`
    internal override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            didPerformShakeEvent?(event)
        }
    }
    
}

// MARK: - Target actions

internal extension OverlayViewController {
    
    /// Handle action on touch up inside on `floatingButton`
    ///
    /// - Parameter button: floating button instance
    @objc internal func didTapFloatingButton(button: UIButton) {
        didTapFloatingButton?(button)
    }
    
}
