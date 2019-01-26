//
//  BPSwizzlingParent+BPSwizzling.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSwizzlingParent+BPSwizzling.h"
#import "NSObject+BPAdd.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation BPSwizzlingParent (BPSwizzling)


// 加载分类到内存的时候调用
+ (void)load {
    [self p_swizzleMethods:[self class] originalSelector:@selector(foo) swizzledSelector:@selector(p_foo)];
}

// 不能在分类中重写方法foo，因为会把系统的功能给覆盖掉，而且分类中不能调用super.

- (void)p_foo {
    // 这里调用s_foo，相当于调用foo
    [self p_foo];
    NSLog(@"Parent swizzle %@",[self class]);
}

@end
