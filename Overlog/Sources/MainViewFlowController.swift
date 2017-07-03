//
// SettingsFlowController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class MainViewFlowController: FlowController, MainViewControllerFlowDelegate {

    typealias ViewController = UINavigationController
    internal var rootViewController: UINavigationController?

    fileprivate let userDefaultsViewController: UserDefaultsViewController


    /// Initializes settings flow controller
    ///
    /// - Parameter navigationController: A navigation controller responsible for controlling the flow
    init(with navigationController: UINavigationController) {
        rootViewController = navigationController
        userDefaultsViewController = UserDefaultsViewController()
        userDefaultsViewController.flowDelegate = self
    }
    
    /// Starts the flow by presenting settings controller on a given controller
    ///
    /// - Parameter viewController: A controller to present on
    internal func present(on viewController: UIViewController) {
        /// Present the settings navigation controller on overlay controler
        guard let navigationController = rootViewController else { return }
        viewController.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - MainView flow delegate
    
    func didTapCloseButton(with sender: UIBarButtonItem) {
        /// Dismiss modally presented settings navigation controller
        rootViewController?.dismiss(animated: true, completion: nil)
    }

    /// Tells the flow delegate that some feature was clicked.
    ///
    /// - Parameter feature: selected feature.
    func didSelect(feature: FeatureType) {
        switch feature {
            case .userDefaults:
                /// Show  userDefaults view
                rootViewController?.pushViewController(userDefaultsViewController, animated: true)
            case .network:
                /// show http view
                break
        }
    }
}

extension MainViewFlowController: UserDefaultsViewControllerFlowDelegate {
    func didTapShareButton(withItems activityItems: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            .airDrop,
            .postToFacebook,
            .postToVimeo,
            .postToWeibo,
            .postToFlickr,
            .postToTwitter,
            .addToReadingList,
            .assignToContact
        ]

        userDefaultsViewController.present(activityViewController, animated: true, completion: nil)
    }
}
