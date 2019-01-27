//
//  OverlayFlowController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class OverlayFlowController: OverlayViewControllerFlowDelegate {
    
    typealias ViewController = OverlayViewController
    internal var rootViewController: OverlayViewController?
    
    /// Child controller responsible for handling the settings flow
    fileprivate var mainFlowController: MainViewFlowController?

    /// Main view controller instance
    fileprivate let mainViewController: MainViewController

    /// Overlog configuration.
    fileprivate let configuration: Overlog.Configuration
    
    /// Default window of application, passed at init
    fileprivate weak var applicationWindow: UIWindow?
    
    /// Window for displaying overlog overlay icon
    fileprivate var overlayWindow: UIWindow?

    /// Initializes Overlog's root flow controller
    ///
    /// - Parameters:
    ///   - window: Application's main window
    ///   - configuration: Overlog configuration
    init(with window: UIWindow, configuration: Overlog.Configuration) {
        self.applicationWindow = window
        self.configuration = configuration

        /// Create and configure overlay view controller
        rootViewController = OverlayViewController()

        /// Create and configure child flow controller
        mainViewController = MainViewController(configuration: configuration)
        mainFlowController = MainViewFlowController(with: BaseNavigationController(rootViewController: mainViewController), configuration: configuration)

        /// Extract the root controller from optional and set self as flow delegate
        guard let rootViewController = rootViewController else { return }
        rootViewController.flowDelegate = self
        mainFlowController?.delegate = self
        
        /// Init separate window for overlay view controller and set it as root
        overlayWindow = UIWindow(frame: rootViewController.overlayView.floatingButton.frame)
        overlayWindow?.windowLevel = UIWindow.Level.alert
        overlayWindow?.rootViewController = rootViewController
        overlayWindow?.isHidden = false
        
        /// Overlay window has to be key window to be able to receive shake gestures
        overlayWindow?.makeKey()
        
        /// Replaces the default iOS navigation back button with a custom one
        setupGeneralNavigationLayout()
    }

    // MARK: - Overlay flow delegate
    
    func didTapFloatingButton(with sender: UIButton) {
        /// Get current displaying view controller
        guard let rootViewController = getCurrentTopViewController(rootViewController: applicationWindow?.rootViewController) else { return }
        
        /// Assign the delegate and present the navigation controller
        mainViewController.flowDelegate = mainFlowController
        mainFlowController?.present(on: rootViewController)
    }
    
    func didEndDraggingFloatingButton(deltaMove: CGPoint) {
        /// Extract overlay window and change its position according to movement delta
        guard let overlayWindow = overlayWindow else { return }
        let startPosition = overlayWindow.center
        overlayWindow.center = CGPoint(x: startPosition.x + deltaMove.x, y: startPosition.y + deltaMove.y)
    }
    
    // MARK: - Helpers
    
    /// Gets view controller that is currently visible for user. Also works with Navigation Controllers and Tab Bar Controllers
    ///
    /// - Parameter rootViewController: Controller when looking for visible vc starts
    /// - Returns: Currently visible for user view controller
    private func getCurrentTopViewController(rootViewController: UIViewController?) -> UIViewController? {
        guard let presented = rootViewController?.presentedViewController else {
            return rootViewController
        }
        if let navigationController = presented as? UINavigationController {
			return getCurrentTopViewController(rootViewController: navigationController.viewControllers.last)
        }
		if let tabBarController = presented as? UITabBarController {
            return getCurrentTopViewController(rootViewController: tabBarController.selectedViewController)
        }
        return getCurrentTopViewController(rootViewController: presented)
    }
}

private extension OverlayFlowController {
    func setupGeneralNavigationLayout() {
        UINavigationBar.loadBackAppearance()
    }
}

extension OverlayFlowController: MainViewFlowControllerDelegate {

    func controller(_ controller: MainViewFlowController, didGetEventOfType feature: Overlog.Feature) {
        if configuration.enabledFeatures.contains(feature), let emojiTitle = feature.emojiTitle {
            rootViewController?.overlayView.animateTitleChange(to: emojiTitle, duration: 1)
        }
    }
    
    func controller(_ controller: MainViewFlowController, toggleOverlogVisibilityToState visible: Bool) {
        overlayWindow?.isHidden = visible
        /// When showing overlog window it has to be set as key window again to receive shake gestures
        if !visible {
            overlayWindow?.makeKey()
        }
        
        /// Prevents from rotating notification bar when Overlog is visible
        rootViewController?.shouldAllowAutorotation = !visible
    }
}
