//
// Notification+Extensions.swift
//
// Copyright © 2018 Netguru Sp. z o.o.. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

internal extension Notification.Name {

    /// Enabled features of Overlog did change.
    internal static var overlogEnabledFeaturesDidChange: Notification.Name {
        return .init(rawValue: "OVLEnabledFeaturesDidChange")
    }

}
