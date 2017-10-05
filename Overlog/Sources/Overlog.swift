//
//  Overlog.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

/// An Overlog abstraction
public final class Overlog {
    
    /// Name of the notification to register if any object wants to be notified about any changes in url configuration.
    public static let URLConfigurationDidChangeNotificationKey = Notification.Name(rawValue: "OVLURLConfigurationDidChange")
    
    /// Overlog configuration.
    public let configuration = Configuration()
    
    /// Overlog customized url.
    ///
    /// - Note: Available only when feature type .url is enabled.
    public var url: (scheme: String, host: String)? {
        guard
            configuration.containsFeature(ofType: .url),
            let host = URLConfigurationStorage.host else {
                return nil
        }
        return (URLConfigurationStorage.scheme.rawValue, host)
    }
    
    /// A Boolean value that determines whether the overlog floating button is hidden.
    /// - Discussion:
    ///     - Setting the value of this property to true hides the floating button and setting it to false shows the it. The default value is false.
    public var isHidden: Bool = false {
        didSet {
            /// Extract the root view controller and configure the floating button
            guard let rootViewController = flowController?.rootViewController else { return }
            rootViewController.overlayView.floatingButton.isHidden = isHidden
        }
    }

    /// Overlay's root flow controller
    fileprivate var flowController: OverlayFlowController?

    /// Initializer
    internal init() {
        flowController = nil
    }

    /// Shows overlay
    ///
    /// - Parameters:
    ///   - window: application's main window
    ///   - viewController: the main window's root view controller
    public func show(in window: UIWindow, rootViewController viewController: UIViewController) {
        flowController = OverlayFlowController(with: viewController, window: window, configuration: configuration)

        /// Extract the root view controller and configure the events
        guard let rootViewController = flowController?.rootViewController else { return }
        rootViewController.didPerformShakeEvent = didPerformShake(event:)
    }

    /// Enable network debugging
    ///
    /// - Parameter configuration: URLSessionConfiguration to be used
    public func enableNetworkDebugging(inConfiguration configuration: URLSessionConfiguration) {
        NetworkMonitor.shared.watch(on: configuration)
    }

    /// Shared instance
    public static let shared = Overlog()

    /// Shake event.
    ///
    /// - Parameter event: A shake event to be handled.
    private func didPerformShake(event _: UIEvent?) {
        if configuration.toggleOnShakeGesture {
            isHidden = !isHidden
        }
    }
    
}
