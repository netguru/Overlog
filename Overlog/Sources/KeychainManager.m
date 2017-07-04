//
// KeychainManager.m
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

#import "KeychainManager.h"

NSString * const OVLKeychainManagerKeyReference = @"keyName";
NSString * const OVLKeychainManagerServiceReference = @"serviceName";

@implementation KeychainManager

- (NSArray<NSDictionary *> *)allKeys {
    /// Create an array for the results
    NSMutableArray<NSDictionary *> *result = [[NSMutableArray alloc] init];
    
    /// Build a query dictionary
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnAttributes, (__bridge id)kSecMatchLimitAll, (__bridge id)kSecMatchLimit, nil];
    
    /// Build an array of queried classes
    NSArray *secureItemClasses = [NSArray arrayWithObjects:(__bridge id)kSecClassGenericPassword, (__bridge id)kSecClassInternetPassword, (__bridge id)kSecClassCertificate, (__bridge id)kSecClassKey, (__bridge id)kSecClassIdentity, nil];
    
    [secureItemClasses enumerateObjectsUsingBlock:^(id  _Nonnull secureItemClass, NSUInteger index, BOOL * _Nonnull stop) {
        [query setObject:secureItemClass forKey:(__bridge id)kSecClass];
        
        CFTypeRef dataTypeRef = NULL;
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataTypeRef);
        if (status == errSecSuccess) {
            /// Retrieve key name and service name for Keychain entry
            NSArray *resultData = (__bridge NSArray *)dataTypeRef;
            [resultData enumerateObjectsUsingBlock:^(NSDictionary *entry, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
                NSString *key = [self stringForReference:kSecAttrAccount inDictionary:entry];
                if (key) {
                    [dictionary setObject:key forKey:OVLKeychainManagerKeyReference];
                }
                NSString *service = [self stringForReference:kSecAttrService inDictionary:entry];
                if (service) {
                    [dictionary setObject:service forKey:OVLKeychainManagerServiceReference];
                }
                /// If there's at least one key set, add the dictionary to results array
                if (dictionary.allKeys.count > 0) {
                    [result addObject:[dictionary copy]];
                }
            }];
            CFRelease(dataTypeRef);
        }
    }];
    
    /// Return the array of keychain entries
    return [result copy];
}

#pragma mark Helpers

- (NSString *)stringForReference:(CFStringRef)reference inDictionary:(NSDictionary *)dictionary {
    NSString *referenceKey = (__bridge NSString *)reference;
    id keyData = dictionary[referenceKey];
    if ([keyData isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:keyData encoding:NSUTF8StringEncoding];
    } else if ([keyData isKindOfClass:[NSString class]]) {
        return keyData;
    } else {
        return nil;
    }
}

@end
