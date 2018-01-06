//
//  NSTimer+BPUnRetain.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSTimer+BPUnRetain.h"

@implementation NSTimer (BPUnRetain)


+ (NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block{
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(bp_blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)bp_blcokInvoke:(NSTimer *)timer {
    
    void (^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

@end
