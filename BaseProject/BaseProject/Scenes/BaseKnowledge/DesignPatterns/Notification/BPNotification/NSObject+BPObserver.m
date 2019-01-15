//
//  NSObject+BPObserver.m
//  PSSNotification
//
//  Created by 泡泡 on 2018/11/13.
//  Copyright © 2018 泡泡. All rights reserved.
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














