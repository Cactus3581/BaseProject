//
//  UIWebView+BPWebStorage.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (BPWebStorage)
#pragma mark - Local Storage

- (void)bp_setLocalStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)bp_localStorageStringForKey:(NSString *)key;

- (void)bp_removeLocalStorageStringForKey:(NSString *)key;

- (void)bp_clearLocalStorage;

#pragma mark - Session Storage

- (void)bp_setSessionStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)bp_sessionStorageStringForKey:(NSString *)key;

- (void)bp_removeSessionStorageStringForKey:(NSString *)key;

- (void)bp_clearSessionStorage;

@end
