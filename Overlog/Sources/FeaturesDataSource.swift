//
//  FeaturesDataSource.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

internal protocol FeaturesDataSource {
    
    /// Provides available features.
    ///
    /// - Returns: All available features.
    func availableFeatures() -> [Feature]
    
    /// Provides enabled features.
    ///
    /// - Returns: All enabled features.
    func enabledFeatures() -> [Feature]
    
    /// Changes enable status of feature with given type.
    ///
    /// - Parameters:
    ///   - type: Type of the feature to change.
    ///   - enable: Indicates whether feature should be enabled or disabled.
    ///
    /// - Returns: Flag indicating whether operation succeeded or failed.
    @discardableResult func feature(_ type: FeatureType, didEnable enable: Bool) -> Bool
    
    /// Name of the notification to register if any object wants to be notified about any changes in available or enabled features.
    var enabledFeaturesDidChangeNotificationKey: Notification.Name { get }
}
