//
// OverlayFlowController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class NetworkTrafficViewFlowController {

    /// The root navigation controller of the flow.
    fileprivate let rootViewController: UINavigationController

    /// Initialiazes network traffic flow controller.
    ///
    /// - Parameter rootViewController: A root view controller of current flow.
    init(with rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    /// Pushes network traffic view controller on navigation stack.
    ///
    /// - Parameter networkTrafficEntries: An array of traffic entries to display.
    func push(with networkTrafficEntries: [NetworkTrafficEntry]) {
        let networkTrafficViewController = NetworkTrafficViewController(networkTrafficEntries: networkTrafficEntries)
        rootViewController.pushViewController(networkTrafficViewController, animated: true)
    }
}
