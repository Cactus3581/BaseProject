
//
//  NSMutableArray+BPAdd.m
//  CatergoryDemo
//
//  Created by xiaruzhen on 16/5/13.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "NSMutableArray+BPAdd.h"
#import "NSArray+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(NSMutableArray_BPAdd)

@implementation NSMutableArray (BPAdd)


- (void)bp_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)bp_removeLastObject {
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

- (id)bp_popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self bp_removeFirstObject];
    }
    return obj;
}

- (id)bp_popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self bp_removeLastObject];
    }
    return obj;
}

- (id)bp_popObjectAtIndexPath:(NSUInteger)index {
    id obj = nil;
    if (self.count) {
        obj = [self bp_objectOrNilAtIndex:index];
        if (obj) {
            [self removeObjectAtIndex:index];
        }
    }
    return obj;
}

- (void)bp_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)bp_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)bp_random {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}
@end
