//
//  NSTimer+JKAddition.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (JKAddition)
/**
 *  @brief  暂停NSTimer
 */
- (void)jk_pauseTimer;
/**
 *  @brief  开始NSTimer
 */
- (void)jk_resumeTimer;
/**
 *  @brief  延迟开始NSTimer
 */
- (void)jk_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
