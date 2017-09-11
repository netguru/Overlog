//
//  Configuration.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

public class Configuration {
    
    /// Toggles presentation of floating button when shake event was received.
    public var toggleOnShakeGesture = true
    
    /// Default configuration storage.
    fileprivate let defaults = UserDefaults.standard

    /// Feature types to configure Overlog
    ///
    /// - Note: **Getter** reads straight from the User Defaults.
    ///         **Setter** checks if new features already exist in the User Defaults.
    ///         If not, then removes corresponding entry from the User Defaults.
    ///         Otherwise assigns enable status (found in appropriate entry) to the corresponding new feature.
    ///
    /// - Warning: Setting this variable will post a notification through NotificationCenter.
    public var features: [FeatureType] {
        get {
            return FeatureType.all.filter { defaults.object(forKey: $0.referenceKey) != nil }
        }
        set {
            FeatureType.all.forEach {
                let exists = newValue.contains($0)
                let enabled = defaults.object(forKey: $0.referenceKey) as? Bool ?? true
                exists ? defaults.set(enabled, forKey:$0.referenceKey) : defaults.removeObject(forKey: $0.referenceKey)
            }

            NotificationCenter.default.post(name: enabledFeaturesDidChangeNotificationKey, object: nil)
        }
    }

    internal func containsFeature(ofType type: FeatureType) -> Bool {
        return availableFeatures().filter { $0.type == type }.first != nil
    }
}

extension Configuration: FeaturesDataSource {
    
    /// Provides available features.
    ///
    /// - Note: Available features are those features which have been saved in the User Defaults.
    ///
    /// - Returns: All available features.
    internal func availableFeatures() -> [Feature] {
        return features.map { Feature(type: $0, enabled: defaults.bool(forKey: $0.referenceKey)) }
    }
    
    /// Provides enabled features.
    ///
    /// - Note: Enabled features are those features which have been saved in the User Defaults and their value is set to 1 (true).
    ///
    /// - Returns: All enabled features.
    internal func enabledFeatures() -> [Feature] {
        return availableFeatures().filter { $0.enabled }
    }
    
    /// Changes enable status of feature with given type only if feature already exists in the User Defaults
    ///
    /// - Parameters:
    ///   - type: Type of the feature to change.
    ///   - enable: Indicates whether feature should be enabled or disabled.
    ///
    /// - Warning: Invoking this function will post a notification through NotificationCenter.
    ///
    /// - SeeAlso: `features`
    @discardableResult internal func feature(_ type: FeatureType, didEnable enable: Bool) -> Bool {
        guard let _ = defaults.object(forKey: type.referenceKey) else {
            return false
        }

        defaults.set(enable, forKey: type.referenceKey)
        NotificationCenter.default.post(name: enabledFeaturesDidChangeNotificationKey, object: nil)

        return true
    }
    
    /// Name of the notification to register if any object wants to be notified about any changes in available or enabled features.
    internal var enabledFeaturesDidChangeNotificationKey: Notification.Name {
        return Notification.Name(rawValue: "OVLEnabledFeaturesDidChange")
    }
}
