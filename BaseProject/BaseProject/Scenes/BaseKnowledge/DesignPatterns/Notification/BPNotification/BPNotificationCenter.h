//
//  BPNotificationCenter.h
//  BaseProject
//
//  Created by Ryan on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPNotification.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BPEventCallBlk)(id info);

@interface BPNotificationCenter : NSObject

+ (instancetype)defaultCenter;

// 注册观察者
- (void)addObserverForName:(NSString *)name observer:(NSObject *)observer usingBlock:(BPEventCallBlk)block;

// 发送通知
- (void)postNotificationName:(NSString *)name info:(id)info;

// 以下自定义的不需要释放了，因为mapTable会随着观察者（在这里就是self）自动释放，mapTable里存放的self和事件也会随着释放

// 移出指定observer下的所有通知
- (void)removeObserver:(NSObject *)observer;

// 移出指定observer下的指定通知
- (void)removeObserver:(NSObject *)observer name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
