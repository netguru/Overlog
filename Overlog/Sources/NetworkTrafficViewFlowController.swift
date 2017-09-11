//
//  NetworkTrafficViewFlowController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class NetworkTrafficViewFlowController: FlowController {

    typealias ViewController = UINavigationController
    internal var rootViewController: UINavigationController?

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
        networkTrafficViewController.flowDelegate = self
        rootViewController?.pushViewController(networkTrafficViewController, animated: true)
    }

    /// Reloads view controller content with received entry.
    ///
    /// - Parameter entry: A traffic entry to be added to current displaying entries.
    public func reload(with entry: NetworkTrafficEntry) {
        rootViewController?.viewControllers.forEach {
            ($0 as? NetworkTrafficViewController)?.reload(with: entry)
            if let viewController = $0 as? TrafficDetailsViewController, viewController.networkTrafficEntry === entry {
                viewController.renderContent()
            }
        }
    }
}

extension NetworkTrafficViewFlowController: NetworkTrafficViewControllerFlowDelegate {

    func didSelect(networkTrafficEntry: NetworkTrafficEntry) {
        let trafficDetailsViewController = TrafficDetailsViewController(networkTrafficEntry: networkTrafficEntry)
        trafficDetailsViewController.flowDelegate = self
        rootViewController?.pushViewController(trafficDetailsViewController, animated: true)
    }
}

extension NetworkTrafficViewFlowController: TrafficDetailsViewControllerFlowDelegate {

    func didTapShareButton(withItems activityItems: [Any]) {
        rootViewController?.present(DefaultActivityViewController(activityItems: activityItems, applicationActivities: nil), animated: true, completion: nil)
    }
}
