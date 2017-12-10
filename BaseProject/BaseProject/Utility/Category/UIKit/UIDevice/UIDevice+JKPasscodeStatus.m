//
//  UIDevice+PasscodeStatus.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIDevice+JKPasscodeStatus.h"
#import <Security/Security.h>

NSString * const UIDevicePasscodeKeychainService = @"UIDevice-PasscodeStatus_KeychainService";
NSString * const UIDevicePasscodeKeychainAccount = @"UIDevice-PasscodeStatus_KeychainAccount";

@implementation UIDevice (JKPasscodeStatus)

- (BOOL)bp_passcodeStatusSupported
{
#if TARGET_IPHONE_SIMULATOR
    return NO;
#endif
    
#ifdef __IPHONE_8_0
    return ((&kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly) != NULL);
#else
    return NO;
#endif
}

- (JKPasscodeStatus)bp_passcodeStatus
{
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"-[%@ %@] - not supported in simulator", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return JKPasscodeStatusUnknown;
#endif
    
#ifdef __IPHONE_8_0
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
    if ((&kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly) != NULL) {
#pragma clang diagnostic pop
        static NSData *password = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            password = [NSKeyedArchiver archivedDataWithRootObject:NSStringFromSelector(_cmd)];
        });
        
        NSDictionary *query = @{
            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
            (__bridge id)kSecAttrService: UIDevicePasscodeKeychainService,
            (__bridge id)kSecAttrAccount: UIDevicePasscodeKeychainAccount,
            (__bridge id)kSecReturnData: @YES,
        };
        
        CFErrorRef sacError = NULL;
        SecAccessControlRef sacObject;
        sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, kNilOptions, &sacError);
        
        // unable to create the access control item.
        if (sacObject == NULL || sacError != NULL) {
            return JKPasscodeStatusUnknown;
        }
        
        
        NSMutableDictionary *setQuery = [query mutableCopy];
        [setQuery setObject:password forKey:(__bridge id)kSecValueData];
        [setQuery setObject:(__bridge id)sacObject forKey:(__bridge id)kSecAttrAccessControl];
        
        OSStatus status;
        status = SecItemAdd((__bridge CFDictionaryRef)setQuery, NULL);
        
        // if it failed to add the item.
        if (status == errSecDecode) {
            return JKPasscodeStatusDisabled;
        }
        
        status = SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
        
        // it managed to retrieve data successfully
        if (status == errSecSuccess) {
            return JKPasscodeStatusEnabled;
        }
        
        // not sure what happened, returning unknown
        return JKPasscodeStatusUnknown;
        
    } else {
        return JKPasscodeStatusUnknown;
    }
#else
    return JKPasscodeStatusUnknown;
#endif
}

@end
