//
//  NSTimer+BPAddition.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BPAddition)
/**
 *  @brief  暂停NSTimer
 */
- (void)_pauseTimer;
/**
 *  @brief  开始NSTimer
 */
- (void)_resumeTimer;
/**
 *  @brief  延迟开始NSTimer
 */
- (void)_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
