//
//  KeychainManager.h
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

@import Foundation;

extern NSString * _Nullable const OVLKeychainManagerKeyReference;
extern NSString * _Nullable const OVLKeychainManagerServiceReference;

@interface KeychainManager : NSObject

NS_ASSUME_NONNULL_BEGIN

/// Returns a list of dictionaries containing keychain key name and associated service name.
///
/// @returns A list of keychain entry dictionaries.
- (NSArray<NSDictionary<NSString *, NSString *> *> *)allEntries;

NS_ASSUME_NONNULL_END

@end
