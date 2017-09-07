//
//  FeaturesDataSource.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

internal protocol FeaturesDataSource {
    func availableFeatures() -> [Feature]
    func enabledFeatures() -> [Feature]
    func feature(_ feature: Feature, didEnable: Bool)
    
    /// Name for the notification informing when available feature has been disabled or enabled
    var enabledFeaturesDidChangeNotificationKey: Notification.Name { get }
}
