//
// KeychainManager.m
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

#import "KeychainManager.h"

@implementation KeychainManager

- (NSArray<NSString *> *)keychainKeys {
    /// Create an array for the results
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    
    /// Build a query dictionary
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnAttributes, (__bridge id)kSecMatchLimitAll, (__bridge id)kSecMatchLimit, nil];
    
    /// Build an array of queried classes
    NSArray *secureItemClasses = [NSArray arrayWithObjects:(__bridge id)kSecClassGenericPassword, (__bridge id)kSecClassInternetPassword, (__bridge id)kSecClassCertificate, (__bridge id)kSecClassKey, (__bridge id)kSecClassIdentity, nil];
    
    [secureItemClasses enumerateObjectsUsingBlock:^(id  _Nonnull secureItemClass, NSUInteger index, BOOL * _Nonnull stop) {
        [query setObject:secureItemClass forKey:(__bridge id)kSecClass];
        
        CFTypeRef keyReference = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &keyReference);
        if (keyReference != NULL) {
            /// Retrieve the key and add it to the array of keys
            NSData *resultData = CFBridgingRelease(keyReference);
            NSString *key = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
            [result addObject:key];
        }
    }];
    
    /// Return the array of keys
    return [result copy];
}

@end
