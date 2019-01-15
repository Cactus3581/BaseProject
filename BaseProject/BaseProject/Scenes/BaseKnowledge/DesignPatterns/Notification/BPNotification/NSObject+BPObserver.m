//
//  NSObject+BPObserver.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "NSObject+BPObserver.h"
#import <objc/runtime.h>

static char BPEventBlkArrayKey;

@implementation NSObject (BPObserver)

- (void)setMuArray:(NSMutableArray *)muArray {
    objc_setAssociatedObject(self, &BPEventBlkArrayKey, muArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)muArray {
    NSMutableArray *muArray = objc_getAssociatedObject(self, &BPEventBlkArrayKey);
    if (!muArray) {
        muArray = @[].mutableCopy;
        [self setMuArray:muArray];
    }
    return muArray;
}

@end














