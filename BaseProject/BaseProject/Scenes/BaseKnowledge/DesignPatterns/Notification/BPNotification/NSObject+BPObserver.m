//
//  NSObject+BPObserver.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "NSObject+BPObserver.h"
#import "BPEventBlkPool.h"
#import <objc/runtime.h>

static char BPEventBlkPoolKey;

@implementation NSObject (BPObserver)

- (void)setEventBlkPool:(BPEventBlkPool *)eventBlkPool {
    objc_setAssociatedObject(self, &BPEventBlkPoolKey, eventBlkPool, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BPEventBlkPool *)eventBlkPool {
    BPEventBlkPool *eventBlkPool = objc_getAssociatedObject(self, &BPEventBlkPoolKey);
    if (!eventBlkPool) {
        eventBlkPool = [[BPEventBlkPool alloc] init];
        [self setEventBlkPool:eventBlkPool];
    }
    return eventBlkPool;
}

@end














