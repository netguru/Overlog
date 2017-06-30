//
// OverlayFlowController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class OverlayFlowController: FlowController, OverlayViewControllerFlowDelegate {
    
    typealias ViewController = OverlayViewController
    internal var rootViewController: OverlayViewController?
    
    /// Child controller responsible for handling the settings flow
    fileprivate var settingsFlowController: SettingsFlowController?
    
    /// Initializes Overlog's root flow controller
    ///
    /// - Parameters:
    ///   - viewController: A child view controller of the overlay
    ///   - window: Application's main window
    init(with viewController: UIViewController, window: UIWindow) {
        /// Create and configure overlay view controller
        rootViewController = OverlayViewController()
        
        /// Extract the root controller from optional and set self as flow delegate
        guard let rootViewController = rootViewController else { return }
        rootViewController.flowDelegate = self
        
        /// Configure root's child controller and add it to a view
        rootViewController.addChildViewController(viewController)
        rootViewController.overlayView.embed(view: viewController.view)
        viewController.didMove(toParentViewController: rootViewController)
        
        /// Make the overlay view controller window's root view controller
        window.rootViewController = rootViewController
    }
    
    // MARK: - Overlay flow delegate
    
    func didTapFloatingButton(with sender: UIButton) {
        /// Create and configure child flow controller
        let settingsViewController = SettingsViewController()
        settingsFlowController = SettingsFlowController(with: UINavigationController(rootViewController: settingsViewController))
        
        /// Extract the root view controller
        guard let rootViewController = rootViewController else { return }
        
        /// Assign the delegate and present the navigation controller
        settingsViewController.flowDelegate = settingsFlowController
        settingsFlowController?.present(on: rootViewController)
    }
}
