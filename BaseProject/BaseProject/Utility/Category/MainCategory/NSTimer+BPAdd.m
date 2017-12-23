//
//  NSTimer+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 16/5/14.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "NSTimer+BPAdd.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(NSTimer_BPAdd)

@implementation NSTimer (BPAdd)

static void *bp_timer = "bp_timer";


+ (void)bp_scheduledCommonModesTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeat {
    NSTimer *timer = objc_getAssociatedObject(target, bp_timer);
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:interval target:target selector:selector userInfo:nil repeats:repeat];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        objc_setAssociatedObject(target, bp_timer, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

+ (void)bp_removeTimeOnTarget:(id)target {
    NSTimer *timer = objc_getAssociatedObject(target, bp_timer);
    if (timer) {
        [timer invalidate];
        objc_setAssociatedObject(target, bp_timer, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}

+ (NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(dispatch_block_t)block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(_bp_doBlock:) userInfo:[block copy] repeats:repeats];
}

+ (void)_bp_doBlock:(NSTimer *)timer{
    dispatch_block_t block = timer.userInfo;
    doBlock(block);
}


@end
