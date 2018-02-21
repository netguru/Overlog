//
// Overlog.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

/// An Overlog abstraction
public final class Overlog {

    // MARK: Nested types

    /// Features of Overlog.
    public enum Feature {

        /// HTTP Traffic dump feature.
        case httpTraffic

        /// User defaults dump feature.
        case userDefaults

        /// Keychain dump feature.
        case keychain

        /// Logs dump feature.
        case logs

        // MARK: Properties

        /// All available features.
        static public var all: Set<Feature> {
            return [.httpTraffic, .userDefaults, .keychain, .logs]
        }

    }

    /// Configuration of Overlog.
    public final class Configuration {

        // MARK: Initializers

        /// Initialize an Overlog configuration.
        internal init() {}

        // MARK: Properties

        /// Enabled Overlog features.
        public var enabledFeatures = Feature.all {
            didSet {
                NotificationCenter.default.post(name: .overlogEnabledFeaturesDidChange, object: nil)
            }
        }

        /// Whether Overlog Button should toggle when user shakes the device.
        public var toggleButtonOnShake = false

        /// A custom keychain service identifier used by Overlog.
        public var keychainIdentifier = String?.none

    }

    // MARK: Initializers

    /// Initialize an instance.
    ///
    /// - Note: This is `internal`, not `private`, so that `Overlog` instances
    ///   can be tested.
    internal init() {
        flowController = nil
    }

    /// Shared instance of Overlog.
    public static let shared = Overlog()

    // MARK: Properties

    /// Overlog configuration.
    public let configuration = Configuration()

    /// The root flow controller.
    private var flowController: OverlayFlowController?

    /// Whether Overlog button is currently hidden.
    public var isHidden: Bool = false {
        didSet {
            flowController?.rootViewController?.overlayView.floatingButton.isHidden = isHidden
        }
    }

    // MARK: Appearance

    /// Attach Overlog to a window.
    ///
    /// - Parameters:
    ///     - window: A window in which Overlog will be shown.
    public func attach(to window: UIWindow) {
        flowController = OverlayFlowController(with: window, configuration: configuration)
    }

    // MARK: HTTP Traffic

    /// Enable HTTP traffic debugging in given URL session configuration.
    /// Overlog is only able to sniff HTTP traffic on URL sessions using that
    /// configuration.
    ///
    /// - Parameters:
    ///     - configuration: An instance of URL session configuration.
    public func enableHTTPTrafficDebugging(in configuration: URLSessionConfiguration) {
        NetworkMonitor.shared.watch(on: configuration)
    }

}

// MARK: -

internal extension Overlog.Feature {

    /// A localized title of this feature.
    internal var localizedTitle: String {
        switch self {
            case .httpTraffic: return "HTTP Traffic".localized
            case .userDefaults: return "User Defaults".localized
            case .keychain: return "Keychain".localized
            case .logs: return "Logs".localized
        }
    }

    /// An emoji icon title of this feature.
    internal var emojiTitle: String? {
        switch self {
            case .httpTraffic: return "\u{1F30D}"
            case .keychain: return "\u{1F510}"
            default: return nil
        }
    }

    /// A sort order of this feature. Used in
    internal var sortOrder: Int {
        switch self {
            case .httpTraffic: return 1
            case .userDefaults: return 2
            case .keychain: return 3
            case .logs: return 4
        }
    }

}

internal extension Overlog.Configuration {

    /// Sorted array of enabled features.
    internal var sortedEnabledFeatures: [Overlog.Feature] {
        return enabledFeatures.sorted { $0.sortOrder < $1.sortOrder }
    }

}
