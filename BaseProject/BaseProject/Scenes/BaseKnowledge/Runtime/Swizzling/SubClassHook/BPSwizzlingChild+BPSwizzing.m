//
//  BPSwizzlingChild+BPSwizzing.m
//  BaseProject
//
//  Created by Ryan on 2019/1/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSwizzlingChild+BPSwizzing.h"
#import "NSObject+BPSwizzling.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation BPSwizzlingChild (BPSwizzing)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self bp_swizzleInstanceMethodWithClass:[self class] originalSelector:@selector(foo) swizzledSelector:@selector(s_foo)];
    });
}

- (void)s_foo {
    [self s_foo];
    NSLog(@"%@ 子分 newIMP",[self class]);
}

@end
