//
// KeychainManager.h
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

@import Foundation;

@interface KeychainManager : NSObject

NS_ASSUME_NONNULL_BEGIN

/// Returns a list of keychain keys available for the app.
///
/// @returns A list of keychain keys.
- (NSArray<NSString *> *)keychainKeys;

NS_ASSUME_NONNULL_END

@end
