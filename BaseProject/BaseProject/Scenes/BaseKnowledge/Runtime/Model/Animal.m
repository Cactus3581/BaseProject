//
//  Animal.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/6.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "Animal.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation Animal

#pragma mark - 实现不提供声明和实现，不修改调用对象，而是修改方法

// 第一步：我们不动态添加方法，返回NO，进入第二步；
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

// 第二步：我们不指定备选对象响应aSelector，进入第三步；
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

// 第三步：返回方法选择器，然后进入第四步；
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sing"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// 第四步：这步我们修改调用方法
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation setSelector:@selector(dance)];
    // 这还要指定是哪个对象的方法
    [anInvocation invokeWithTarget:self];
}

// 若forwardInvocation没有实现，则会调用此方法
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    BPLog(@"消息无法处理：%@", NSStringFromSelector(aSelector));
}

- (void)dance {
    BPLog(@"跳舞！！！come on！");
}

@end
