//
//  BPNotificationCenter.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPEventBlk.h"

NS_ASSUME_NONNULL_BEGIN

@class BPEventBlkPool;

@interface BPNotificationCenter : NSObject

+ (instancetype)defaultCenter;

// 注册观察者
- (void)addObserverForName:(NSString *)name observer:(NSObject *)observer usingBlock:(BPEventCallBlk)block;

// 发送通知
- (void)postNotificationName:(NSString *)name info:(id)info;

// 移出指定observer下的所有通知
- (void)removeObserver:(NSObject *)observer;

// 移出指定observer下的指定通知
- (void)removeObserver:(NSObject *)observer name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
