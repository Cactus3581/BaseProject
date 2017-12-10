//
//  NSObject+JKGCD.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface NSObject (JKGCD)
/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)jk_performAsynchronous:(void(^)(void))block;
/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)jk_performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)jk_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;
@end
