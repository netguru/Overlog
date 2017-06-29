//
// Overlay.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

/// An Overlay abstraction
public final class Overlay {
    
    /// Toggle's presentation of floating button when shake event was received.
    public var toggleOnShakeGesture: Bool = true
    
    /// Overlay's root flow controller
    fileprivate let flowController: OverlayFlowController
    
    /// Overlay initializer
    ///
    /// - Parameters:
    ///   - window: application's main window
    ///   - viewController: the main window's root view controller
    public init(window: UIWindow, rootViewController viewController: UIViewController) {
        flowController = OverlayFlowController(with: viewController, window: window)
        flowController.rootViewController.didPerformShakeEvent = didPerformShake(event:)
    }
    
    /// Presents floating button
    /// - Discussion:
    ///     - This methods sets `isHidden` to `true` on `OverlayView`'s `floatingButton` only
    public func present() {
        flowController.rootViewController.overlayView.floatingButton.isHidden = false
    }
    
    /// Hides floating button
    /// - Discussion:
    ///     - This methods sets `isHidden` to `false` on `OverlayView`'s `floatingButton` only
    public func hide() {
        flowController.rootViewController.overlayView.floatingButton.isHidden = true
    }
    
    /// Shake event
    ///
    /// - Parameter overlayView: overlayView description
    private func didPerformShake(event _: UIEvent?) {
        if toggleOnShakeGesture {
            let overlayView = flowController.rootViewController.overlayView
            overlayView.floatingButton.isHidden = !overlayView.floatingButton.isHidden
        }
    }
    
}
