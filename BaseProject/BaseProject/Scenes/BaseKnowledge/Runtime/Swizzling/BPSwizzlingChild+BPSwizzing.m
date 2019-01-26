//
//  BPSwizzlingChild+BPSwizzing.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSwizzlingChild+BPSwizzing.h"
#import "NSObject+BPAdd.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation BPSwizzlingChild (BPSwizzing)


// 加载分类到内存的时候调用
+ (void)load {
    [self p_swizzleMethods:[self class] originalSelector:@selector(foo) swizzledSelector:@selector(s_foo)];
}

// 不能在分类中重写方法foo，因为会把系统的功能给覆盖掉，而且分类中不能调用super.

- (void)s_foo {
    // 这里调用s_foo，相当于调用foo
    [self s_foo];
    NSLog(@"Chaild swizzle %@",[self class]);
}

@end
