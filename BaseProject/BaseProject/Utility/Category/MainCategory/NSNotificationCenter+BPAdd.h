//
//  NSNotificationCenter+BPAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (BPAdd)
/**保证通知在主线程上执行*/
- (void)bp_postNotificationOnMainThread:(NSNotification *)notification;
- (void)bp_postNotificationOnMainThread:(NSNotification *)notification
                             waitUntilDone:(BOOL)wait;
- (void)bp_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object;
- (void)bp_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object
                                          userInfo:(nullable NSDictionary *)userInfo;
- (void)bp_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object
                                          userInfo:(nullable NSDictionary *)userInfo
                                     waitUntilDone:(BOOL)wait;

@end

NS_ASSUME_NONNULL_END

