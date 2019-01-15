//
//  PSSNotificationCenter.h
//  PSSNotification
//
//  Created by 泡泡 on 2018/11/13.
//  Copyright © 2018 泡泡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPEventBlk.h"

#define kDefaultNotificationName @"PSSDefaultNotification"
@class BPEventBlkPool;
@interface BPNotificationCenter : NSObject

+ (instancetype)defaultCenter;

- (void)addEvent:(BPEventCallBlk)event eventName:(NSString *)eventName observer:(NSObject *)observer;

/// info: 传值
- (void)postNotificationByName:(NSString *)name info:(id)info;



/// 移出对应通知事件
- (void)removeNotificationName:(NSString *)name;
/// 移出所有通知下的 observer对应的事件（不给此observer发送事件了）
- (void)removeObserver:(NSObject *)observer;
- (void)removeObserverByEventBlkPool:(BPEventBlkPool *)eventBlkPool;
/// 移出对应通知下，对应observer的事件
- (void)removeNotificationName:(NSString *)name observer:(NSObject *)observer;
/// 移出所有事件
- (void)removeAllNoti;

@end
