//
//  Configuration.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

public class Configuration {
    
    /// Toggle's presentation of floating button when shake event was received.
    public var toggleOnShakeGesture = true
    
    /// Feature types to configure Overlog
    public var features: [FeatureType] {
        get {
            return FeatureType.all.filter { UserDefaults.standard.object(forKey: $0.referenceKey) != nil }
        }
        set {
            let defaults = UserDefaults.standard
            FeatureType.all.forEach {
                let exists = newValue.contains($0)
                let enabled = defaults.object(forKey: $0.referenceKey) as? Bool ?? true
                exists ? defaults.set(enabled, forKey:$0.referenceKey) : defaults.removeObject(forKey: $0.referenceKey)
            }

            NotificationCenter.default.post(name: enabledFeaturesDidChangeNotificationKey, object: nil)
        }
    }
}

extension Configuration: FeaturesDataSource {
    
    internal func availableFeatures() -> [Feature] {
        return features.map { Feature(type: $0, enabled: UserDefaults.standard.bool(forKey: $0.referenceKey)) }
    }
    
    internal func feature(_ feature: Feature, didEnable enable: Bool) {
        UserDefaults.standard.set(enable, forKey: feature.type.referenceKey)
        NotificationCenter.default.post(name: enabledFeaturesDidChangeNotificationKey, object: nil)
    }
    
    internal func enabledFeatures() -> [Feature] {
        return availableFeatures().filter { $0.enabled }
    }
    
    var enabledFeaturesDidChangeNotificationKey: Notification.Name {
        return Notification.Name(rawValue: "OVLEnabledFeaturesDidChange")
    }
}
