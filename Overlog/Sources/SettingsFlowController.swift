//
// SettingsFlowController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class SettingsFlowController: FlowController, SettingsViewControllerFlowDelegate {
    
    typealias ViewController = UINavigationController
    internal weak var rootViewController: UINavigationController?
    
    /// Initializes settings flow controller
    ///
    /// - Parameter navigationController: A navigation controller responsible for controlling the flow
    init(with navigationController: UINavigationController) {
        self.rootViewController = navigationController
    }
    
    /// Starts the flow by presenting settings controller on a given controller
    ///
    /// - Parameter viewController: A controller to present on
    internal func present(on viewController: UIViewController) {
        /// Present the settings navigation controller on overlay controler
        guard let navigationController = self.rootViewController else { return }
        viewController.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Settings flow delegate
    
    func didTapCloseButton(with sender: UIBarButtonItem) {
        /// Dismiss modally presented settings navigation controller
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
