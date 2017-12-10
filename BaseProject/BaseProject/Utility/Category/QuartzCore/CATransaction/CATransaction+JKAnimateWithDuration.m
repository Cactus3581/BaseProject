//
//  CATransaction+AnimateWithDuration.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "CATransaction+JKAnimateWithDuration.h"

@implementation CATransaction (JKAnimateWithDuration)
/**
 *  @author Denys Telezhkin
 *
 *  @brief  CATransaction 动画执 block回调
 *
 *  @param duration   动画时间
 *  @param animations 动画块
 *  @param completion 动画结束回调
 */
+(void)jk_animateWithDuration:(NSTimeInterval)duration
                   animations:(void (^)(void))animations
                   completion:(void (^)(void))completion
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    
    if (completion)
    {
        [CATransaction setCompletionBlock:completion];
    }
    
    if (animations)
    {
        animations();
    }
    [CATransaction commit];
}

@end
