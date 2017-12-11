//
//  OverlayFlowController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class OverlayFlowController: FlowController, OverlayViewControllerFlowDelegate {
    
    typealias ViewController = OverlayViewController
    internal var rootViewController: OverlayViewController?
    
    /// Child controller responsible for handling the settings flow
    fileprivate var mainFlowController: MainViewFlowController?

    /// Main view controller instance
    fileprivate let mainViewController: MainViewController

    /// Overlog configuration.
    fileprivate let configuration: Configuration
    
    fileprivate weak var applicationWindow: UIWindow?
    
    fileprivate var overlayWindow: UIWindow?

    /// Initializes Overlog's root flow controller
    ///
    /// - Parameters:
    ///   - viewController: A child view controller of the overlay
    ///   - window: Application's main window
    init(with viewController: UIViewController, window: UIWindow, configuration: Configuration) {
        self.applicationWindow = window
        self.configuration = configuration

        /// Create and configure overlay view controller
        rootViewController = OverlayViewController()

        /// Create and configure child flow controller
        mainViewController = MainViewController(featuresDataSource: configuration)
        mainFlowController = MainViewFlowController(with: UINavigationController(rootViewController: mainViewController), configuration: configuration)

        /// Extract the root controller from optional and set self as flow delegate
        guard let rootViewController = rootViewController else { return }
        
        rootViewController.view.frame = viewController.view.bounds
        
        overlayWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        overlayWindow?.windowLevel = UIWindowLevelAlert + 1
        overlayWindow?.rootViewController = rootViewController
        overlayWindow?.isHidden = false
        
        /// Overlay window has to be key window to be able to receive shake gestures
        overlayWindow?.makeKey()
        
        rootViewController.flowDelegate = self
        
        /// Configure root's child controller and add it to a view
//        viewController.view.frame = rootViewController.view.bounds
//        rootViewController.addChildViewController(viewController)
//        rootViewController.view.addSubview(viewController.view)
//        viewController.didMove(toParentViewController: rootViewController)

    
        mainFlowController?.delegate = self
    }

    // MARK: - Overlay flow delegate
    
    func didTapFloatingButton(with sender: UIButton) {
        /// Extract the root view controller
        guard let rootViewController = getCurrentTopViewController(rootViewController: applicationWindow?.rootViewController) else { return }
        
        /// Assign the delegate and present the navigation controller
        mainViewController.flowDelegate = mainFlowController
        mainFlowController?.present(on: rootViewController)
    }
    
    func didEndDraggingFloatingButton(deltaMove: CGPoint) {
        guard let overlayWindow = overlayWindow else { return }
        let startPosition = overlayWindow.center
        let positionToSet = CGPoint(x: startPosition.x + deltaMove.x, y: startPosition.y + deltaMove.y)
        overlayWindow.center = positionToSet
    }
    
    private func getCurrentTopViewController(rootViewController: UIViewController?) -> UIViewController? {
        guard let presented = rootViewController?.presentedViewController else {
            return rootViewController
        }
        
        if presented.isKind(of: UINavigationController.self) {
            let navigationController = presented as? UINavigationController
            return getCurrentTopViewController(rootViewController: navigationController?.viewControllers.last)
        }
    
        if presented.isKind(of: UITabBarController.self) {
            let tabBarController = presented as? UITabBarController
            return getCurrentTopViewController(rootViewController: tabBarController?.selectedViewController)
        }
        
        return getCurrentTopViewController(rootViewController: presented)
    }
}

extension OverlayFlowController: MainViewFlowControllerDelegate {

    func controller(_ controller: MainViewFlowController, didGetEventOfType eventType: FeatureType) {
        let featureEnabled = configuration.enabledFeatures().filter { $0.type == eventType }.first != nil
        if featureEnabled {
            rootViewController?.overlayView.animateTitleChange(from: eventType.icon, duration: 1)
        }
    }
}
