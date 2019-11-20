//
//  BPSwizzlingParent+BPSwizzlingB.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/10/25.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSwizzlingParent+BPSwizzlingB.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+BPSwizzling.h"

@implementation BPSwizzlingParent (BPSwizzlingB)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self bp_swizzleInstanceMethodWithClass:[self class] originalSelector:@selector(foo) swizzledSelector:@selector(p1_foo)];
    });
}

- (void)p1_foo {
    [self p1_foo];
    NSLog(@"%@ 主分2 newIMP",[self class]);
}

@end
