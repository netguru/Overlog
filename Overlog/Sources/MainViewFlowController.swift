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

    /// Child flow controllers
    fileprivate let networkTrafficViewFlowController: NetworkTrafficViewFlowController

    /// Logs monitors for reading and notifying about logs
    fileprivate var consoleLogsMonitor: ConsoleLogsMonitor?
    fileprivate var systemLogsMonitor: SystemLogsMonitor?

    /// Items monitor for reading and notifying about keychain's content.
    fileprivate var keychainMonitor: KeychainMonitor?

    /// Network monitor for intercepting and notifying about requests and responses
    fileprivate var networkMonitor: NetworkMonitor?

    /// User defaults monitor for reading and notifying about user defaults' content.
    fileprivate var userDefaultsMonitor: UserDefaultsMonitor?

    /// Configuration to apply.
    fileprivate let configuration: Configuration

    /// View controller for displaying user defaults items.
    fileprivate lazy var userDefaultsViewController: UserDefaultsViewController? = {
        return self.userDefaultsMonitor != nil ? {
            let controller = UserDefaultsViewController()
            controller.flowDelegate = self
            
            return controller
        }() : nil
    }()

    /// View controller for displaying keychain items.
    fileprivate lazy var keychainViewController: KeychainViewController? = {
        return self.keychainMonitor != nil ? KeychainViewController() : nil
    }()

    /// View controller for displaying console logs.
    fileprivate lazy var consoleLogsViewController: LogsViewController? = {
        return self.consoleLogsMonitor != nil ? LogsViewController() : nil
    }()

    /// View controller for displaying system logs.
    fileprivate lazy var systemLogsViewController: LogsViewController? = {
        return self.systemLogsMonitor != nil ? LogsViewController() : nil
    }()

    /// Array which holds all network traffic entries
    internal var networkTrafficEntries: [NetworkTrafficEntry] = []

    /// Initializes settings flow controller
    ///
    /// - Parameter navigationController: A navigation controller responsible for controlling the flow
    init(with navigationController: UINavigationController, configuration: Configuration) {
        self.configuration = configuration
        rootViewController = navigationController
        networkTrafficViewFlowController = NetworkTrafficViewFlowController(with: navigationController)

        createMonitors()
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
        let viewController = SettingsViewController(featuresDataSource: configuration)
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
        var viewControllerToPush: UIViewController?
        switch feature {
            case .userDefaults:
                viewControllerToPush = userDefaultsViewController
                userDefaultsMonitor?.subscribeForItems()
            case .keychain:
                viewControllerToPush = keychainViewController
                keychainMonitor?.subscribeForItems()
            case .network:
                networkTrafficViewFlowController.push(with: networkTrafficEntries)
            case .consoleLogs:
                viewControllerToPush = consoleLogsViewController
            case .systemLogs:
                viewControllerToPush = systemLogsViewController
                systemLogsMonitor?.subscribeForLogs()
            case .url:
                viewControllerToPush = URLConfigurationViewController()
        }

        if let viewController = viewControllerToPush {
            rootViewController?.pushViewController(viewController, animated: true)
        }
    }
}

extension MainViewFlowController: UserDefaultsViewControllerFlowDelegate {
    func didTapShareButton(withItems activityItems: [Any]) {
        userDefaultsViewController?.present(DefaultActivityViewController(activityItems: activityItems, applicationActivities: nil), animated: true, completion: nil)
    }
}

extension MainViewFlowController: NetworkMonitorDelegate {
    func monitor(_ monitor: NetworkMonitor, didGet request: RequestRepresentation) {
        let networkTrafficEntry = NetworkTrafficEntry(request: request)
        networkTrafficEntries.append(networkTrafficEntry)
        networkTrafficViewFlowController.reload(with: networkTrafficEntry)
        delegate?.controller(self, didGetEventOfType: .network)
    }

    func monitor(_ monitor: NetworkMonitor, didGet error: ErrorRepresentation) {
        if let currentItem = networkTrafficEntries.filter( { $0.request.identifier == error.requestIdentifier }).first {
            currentItem.error = error
            networkTrafficViewFlowController.reload(with: currentItem)
        }
        delegate?.controller(self, didGetEventOfType: .network)
    }

    func monitor(_ monitor: NetworkMonitor, didGet response: ResponseRepresentation) {
        if let currentItem = networkTrafficEntries.filter( { $0.request.identifier == response.requestIdentifier }).first {
            currentItem.response = response
            networkTrafficViewFlowController.reload(with: currentItem)
        }
        delegate?.controller(self, didGetEventOfType: .network)
    }
}

extension MainViewFlowController: LogsMonitorDelegate {
    func monitor(_ monitor: LogsMonitor, didGet logs: [LogEntry]) {
        if monitor is ConsoleLogsMonitor {
            consoleLogsViewController?.reload(with: logs)
            delegate?.controller(self, didGetEventOfType: .consoleLogs)
        } else {
            systemLogsViewController?.reload(with: logs)
            delegate?.controller(self, didGetEventOfType: .systemLogs)
        }
    }
}

extension MainViewFlowController: KeychainMonitorDelegate {
    func monitor(_ monitor: KeychainMonitor, didGet items: [KeychainItem]) {
        keychainViewController?.reload(with: items)
        delegate?.controller(self, didGetEventOfType: .keychain)
    }
}

extension MainViewFlowController: UserDefaultsMonitorDelegate {
    func monitor(_ monitor: UserDefaultsMonitor, didGet items: [UserDefaultsItem]) {
        userDefaultsViewController?.reload(with: items)
        delegate?.controller(self, didGetEventOfType: .userDefaults)
    }
}

fileprivate extension MainViewFlowController {
    func createMonitors() {
        if configuration.containsFeature(ofType: .network) {
            networkMonitor = NetworkMonitor.shared
            networkMonitor?.delegate = self
        }
        if configuration.containsFeature(ofType: .keychain) {
            let keychain: KeychainMonitorDataSource
            if let serviceIdentifier = configuration.keychainIdentifier {
                keychain = Keychain(service: serviceIdentifier)
            } else {
                keychain = Keychain()
            }
            keychainMonitor = KeychainMonitor(dataSource: keychain)
            keychainMonitor?.delegate = self
        }
        if configuration.containsFeature(ofType: .userDefaults) {
            userDefaultsMonitor = UserDefaultsMonitor(dataSource: UserDefaults.standard)
            userDefaultsMonitor?.delegate = self
        }
        if configuration.containsFeature(ofType: .consoleLogs) {
            print("***\n"
                + "\n"
                + "Overlog has been configured to gather console logs which won't be visible in a console window anymore.\n"
                + "It is a workaround for a fact that stdout and stderr outputs can be redirected only to a one handle.\n"
                + "\n"
                + "***"
            )
            consoleLogsMonitor = ConsoleLogsMonitor()
            consoleLogsMonitor?.delegate = self
            consoleLogsMonitor?.subscribeForLogs()
        }
        if configuration.containsFeature(ofType: .systemLogs) {
            systemLogsMonitor = SystemLogsMonitor()
            systemLogsMonitor?.delegate = self
        }
    }
}

internal protocol MainViewFlowControllerDelegate: class {

    /// Triggered when any event occurs, informs the delegate about
    ///
    /// - parameter controller: A view flow controller receiving events from monitors
    /// - parameter eventType: Type of an event declared as FeatureType
    func controller(_ controller: MainViewFlowController, didGetEventOfType eventType: FeatureType)

}
