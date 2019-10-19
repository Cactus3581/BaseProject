//
//  NSTimer+BPAdd.h
//  BaseProject
//
//  Created by Ryan on 16/5/14.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSTimer (BPAdd)

/**
 *  通过block启用一个自动执行的timer，该方法可解除对timer对target持有可能导致的循环引用问题(timer默认会对target进行持有)
 */
+ (NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(dispatch_block_t)block repeats:(BOOL)repeats;

/**
 *  添加一个自动执行的timer到CommonModes
 *
 *  @param target   方法调用者，也是timer的持有者，调用bp_removeTimeOnTarget停止timer传入该target
 */
+ (void)bp_scheduledCommonModesTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeat;

/**
 *  停止通过上面方法创建的timer
 *
 *  @param target 上面方法的target
 */
+ (void)bp_removeTimeOnTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
