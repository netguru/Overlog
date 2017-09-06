//
//  MainViewFlowController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import ResponseDetective

internal final class MainViewFlowController: FlowController, MainViewControllerFlowDelegate {

    /// A delegate for receiving new events occurences
    internal weak var delegate: MainViewFlowControllerDelegate?

    typealias ViewController = UINavigationController
    internal var rootViewController: UINavigationController?

    /// View controller for displaying user defaults
    fileprivate let userDefaultsViewController: UserDefaultsViewController
    fileprivate let keychainViewController: KeychainViewController
    fileprivate let consoleLogsViewController: LogsViewController
    fileprivate let systemLogsViewController: LogsViewController

    /// Child flow controllers
    fileprivate let networkTrafficViewFlowController: NetworkTrafficViewFlowController

    /// Logs monitors for reading and notifiying about logs
    fileprivate let consoleLogsMonitor: ConsoleLogsMonitor
    fileprivate let systemLogsMonitor: SystemLogsMonitor

    /// Items monitor for reading and notifiying about keychain's content
    fileprivate let keychainMonitor: KeychainMonitor

    /// Array which holds all network traffic entries
    internal var networkTrafficEntries: [NetworkTrafficEntry] = []

    /// Initializes settings flow controller
    ///
    /// - Parameter navigationController: A navigation controller responsible for controlling the flow
    init(with navigationController: UINavigationController) {
        rootViewController = navigationController
        keychainMonitor = KeychainMonitor(dataSource: Keychain())
        keychainViewController = KeychainViewController()
        consoleLogsMonitor = ConsoleLogsMonitor()
        consoleLogsViewController = LogsViewController(logsMonitor: consoleLogsMonitor)
        systemLogsMonitor = SystemLogsMonitor()
        systemLogsViewController = LogsViewController(logsMonitor: systemLogsMonitor)
        userDefaultsViewController = UserDefaultsViewController()
        networkTrafficViewFlowController = NetworkTrafficViewFlowController(with: navigationController)
        NetworkMonitor.shared.delegate = self
        consoleLogsMonitor.delegate = self
        consoleLogsMonitor.subscribeForLogs()
        systemLogsMonitor.delegate = self
        keychainMonitor.delegate = self
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
    
    /// Action performed after tapping close button
    ///
    /// - Parameter sender: close button
    func didTapCloseButton(with sender: UIBarButtonItem) {
        /// Dismiss modally presented settings navigation controller
        rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    /// Action performed after tapping settings button
    ///
    /// - Parameter sender: settings button
    func didTapSettingsButton(with sender: UIBarButtonItem) {
        let viewController = SettingsViewController()
        viewController.modalPresentationStyle = .popover
        guard let popoverPresentationController = viewController.popoverPresentationController else {
            return
        }
        popoverPresentationController.permittedArrowDirections = .up
        popoverPresentationController.barButtonItem = sender
        popoverPresentationController.delegate = viewController
        rootViewController?.present(viewController, animated: true, completion: nil)
    }

    /// Tells the flow delegate that some feature was clicked.
    ///
    /// - Parameter feature: selected feature.
    func didSelect(feature: FeatureType) {
        switch feature {
            case .userDefaults:
                /// Show  userDefaults view
                rootViewController?.pushViewController(userDefaultsViewController, animated: true)
            case .keychain:
                /// Show keychain view
                rootViewController?.pushViewController(keychainViewController, animated: true)
                keychainMonitor.subscribeForItems()
            case .network:
                /// Show view controller for displaying network traffic
                networkTrafficViewFlowController.push(with: networkTrafficEntries)
            case .consoleLogs:
                /// Show console logs view
                rootViewController?.pushViewController(consoleLogsViewController, animated: true)
            case .systemLogs:
                /// Show system logs view
                rootViewController?.pushViewController(systemLogsViewController, animated: true)
                systemLogsMonitor.subscribeForLogs()
        }
    }
}

extension MainViewFlowController: UserDefaultsViewControllerFlowDelegate {
    func didTapShareButton(withItems activityItems: [Any]) {
        userDefaultsViewController.present(DefaultActivityViewController(activityItems: activityItems, applicationActivities: nil), animated: true, completion: nil)
    }
}

extension MainViewFlowController: NetworkMonitorDelegate {
    func monitor(_ monitor: NetworkMonitor, didGet request: RequestRepresentation) {
        networkTrafficEntries.append(NetworkTrafficEntry(request: request))
        delegate?.controller(self, didGetEventOfType: .network)
    }

    func monitor(_ monitor: NetworkMonitor, didGet error: ErrorRepresentation) {
        if let currentItem = networkTrafficEntries.filter( { $0.request.identifier == error.requestIdentifier }).first {
            currentItem.error = error
        }
        delegate?.controller(self, didGetEventOfType: .network)
    }

    func monitor(_ monitor: NetworkMonitor, didGet response: ResponseRepresentation) {
        if let currentItem = networkTrafficEntries.filter( { $0.request.identifier == response.requestIdentifier }).first {
            currentItem.response = response
        }
        delegate?.controller(self, didGetEventOfType: .network)
    }
}

extension MainViewFlowController: LogsMonitorDelegate {

    func monitor(_ monitor: LogsMonitor, didGet logs: [LogEntry]) {
        if monitor is ConsoleLogsMonitor {
            consoleLogsViewController.reload(with: logs)
            delegate?.controller(self, didGetEventOfType: .consoleLogs)
        } else {
            systemLogsViewController.reload(with: logs)
            delegate?.controller(self, didGetEventOfType: .systemLogs)
        }
    }
}

extension MainViewFlowController: KeychainMonitorDelegate {

    func monitor(_ monitor: KeychainMonitor, didGet items: [KeychainItem]) {
        keychainViewController.reload(with: items)
        delegate?.controller(self, didGetEventOfType: .keychain)
    }
}

internal protocol MainViewFlowControllerDelegate: class {

    /// Triggered when any event occurs, informs the delegate about
    ///
    /// - parameter controller: A view flow controller receiving events from monitors
    /// - parameter eventType: Type of an event declared as FeatureType
    func controller(_ controller: MainViewFlowController, didGetEventOfType eventType: FeatureType)

}
