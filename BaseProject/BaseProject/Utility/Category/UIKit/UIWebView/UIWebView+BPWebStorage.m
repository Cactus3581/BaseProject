//
//  UIWebView+BPWebStorage.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIWebView+BPWebStorage.h"

static NSString * const bp_kLocalStorageName = @"localStorage";
static NSString * const bp_kSessionStorageName = @"sessionStorage";


@implementation UIWebView (BPWebStorage)
#pragma mark - Local Storage

- (void)bp_setLocalStorageString:(NSString *)string forKey:(NSString *)key {
    [self bp_ip_setString:string forKey:key storage:bp_kLocalStorageName];
}

- (NSString *)bp_localStorageStringForKey:(NSString *)key {
    return [self bp_ip_stringForKey:key storage:bp_kLocalStorageName];
}

- (void)bp_removeLocalStorageStringForKey:(NSString *)key {
    [self bp_ip_removeStringForKey:key storage:bp_kLocalStorageName];
}

- (void)bp_clearLocalStorage {
    [self bp_ip_clearWithStorage:bp_kLocalStorageName];
}

#pragma mark - Session Storage

- (void)bp_setSessionStorageString:(NSString *)string forKey:(NSString *)key {
    [self bp_ip_setString:string forKey:key storage:bp_kSessionStorageName];
}

- (NSString *)bp_sessionStorageStringForKey:(NSString *)key {
    return [self bp_ip_stringForKey:key storage:bp_kSessionStorageName];
}

- (void)bp_removeSessionStorageStringForKey:(NSString *)key {
    [self bp_ip_removeStringForKey:key storage:bp_kSessionStorageName];
}

- (void)bp_clearSessionStorage {
    [self bp_ip_clearWithStorage:bp_kSessionStorageName];
}

#pragma mark - Helpers

- (void)bp_ip_setString:(NSString *)string forKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.setItem('%@', '%@');", storage, key, string]];
}

- (NSString *)bp_ip_stringForKey:(NSString *)key storage:(NSString *)storage {
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.getItem('%@');", storage, key]];
}

- (void)bp_ip_removeStringForKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.removeItem('%@');", storage, key]];
}

- (void)bp_ip_clearWithStorage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.clear();", storage]];
}
@end
