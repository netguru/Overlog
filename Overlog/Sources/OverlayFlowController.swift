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

    /// Initializes Overlog's root flow controller
    ///
    /// - Parameters:
    ///   - viewController: A child view controller of the overlay
    ///   - window: Application's main window
    init(with viewController: UIViewController, window: UIWindow, configuration: Configuration) {
        self.configuration = configuration

        /// Create and configure overlay view controller
        rootViewController = OverlayViewController()

        /// Create and configure child flow controller
        mainViewController = MainViewController(featuresDataSource: configuration)
        mainFlowController = MainViewFlowController(with: UINavigationController(rootViewController: mainViewController), configuration: configuration)

        /// Extract the root controller from optional and set self as flow delegate
        guard let rootViewController = rootViewController else { return }
        rootViewController.flowDelegate = self
        
        /// Configure root's child controller and add it to a view
        viewController.view.frame = rootViewController.view.bounds
        rootViewController.addChildViewController(viewController)
        rootViewController.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: rootViewController)
        
        /// Make the overlay view controller window's root view controller
        window.rootViewController = rootViewController
        
        mainFlowController?.delegate = self
    }

    // MARK: - Overlay flow delegate
    
    func didTapFloatingButton(with sender: UIButton) {
        /// Extract the root view controller
        guard let rootViewController = rootViewController else { return }
        
        /// Assign the delegate and present the navigation controller
        mainViewController.flowDelegate = mainFlowController
        mainFlowController?.present(on: rootViewController)
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
