//
//  NSNotificationCenter+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSNotificationCenter+BPAdd.h"
#import <pthread.h>

BPSYNTH_DUMMY_CLASS(NSNotificationCenter_BPAdd)

@implementation NSNotificationCenter (BPAdd)


- (void)bp_postNotificationOnMainThread:(NSNotification *)notification {
    if (pthread_main_np()) return [self postNotification:notification];
    [self bp_postNotificationOnMainThread:notification waitUntilDone:NO];
	
}

- (void)bp_postNotificationOnMainThread:(NSNotification *)notification
                             waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotification:notification];
    [self performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:wait];
	
}

- (void)bp_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:nil];
    [self bp_postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
	
}

- (void)bp_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object
                                          userInfo:(nullable NSDictionary *)userInfo {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    [self bp_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
	
}

- (void)bp_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object
                                          userInfo:(nullable NSDictionary *)userInfo
                                     waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(_bp_postNotificationName:) withObject:info waitUntilDone:wait];
	
}

- (void)_bp_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    [self postNotificationName:name object:object userInfo:userInfo];
}
@end
