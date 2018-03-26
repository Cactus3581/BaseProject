//
//  CADisplayLink+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "CADisplayLink+BPAdd.h"
#import <objc/runtime.h>

@implementation CADisplayLink (BPAdd)

- (void)setExecuteBlock:(displayLinkBlock)executeBlock {
    objc_setAssociatedObject(self, @selector(executeBlock), [executeBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (displayLinkBlock)executeBlock{
    return objc_getAssociatedObject(self, @selector(executeBlock));
}

+ (CADisplayLink *)displayLinkWithExecuteBlock:(displayLinkBlock)block {
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(bp_executeDisplayLink:)];
    displayLink.executeBlock = [block copy];
    return displayLink;
}

+ (CADisplayLink *)displayLinkWithRunLoop:(NSRunLoop *)runloop executeBlock:(displayLinkBlock)block {
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(bp_executeDisplayLink:)];
    [displayLink addToRunLoop:runloop forMode:NSRunLoopCommonModes];
    displayLink.executeBlock = [block copy];
    return displayLink;
}

+ (void)bp_executeDisplayLink:(CADisplayLink *)displayLink{
    if (displayLink.executeBlock) {
        displayLink.executeBlock(displayLink);
    }
}

@end
