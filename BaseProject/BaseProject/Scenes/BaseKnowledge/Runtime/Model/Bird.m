//
//  Bird.m
//  BaseProject
//
//  Created by Ryan on 2018/12/6.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "Bird.h"
#import "People.h"

@implementation Bird
#pragma mark - 动态更换调用对象

// 第一步：我们不动态添加方法，返回NO，进入第二步；
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

// 第二步：我们不指定备选对象响应aSelector，进入第三步；
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if ([NSStringFromSelector(aSelector) isEqualToString:@"sing"]) {
//        return [[People alloc] init];//只要这个方法返回的不是 nil 和 self，整个消息发送的过程就会被重启
//    }
//    return nil;
//}

// 第三步：返回方法选择器，然后进入第四步；
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sing"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// 第四步：这步我们修改调用对象
/**
 在这个方法里，我们可以修改方法，也可以将消息转发给其他对象来处理
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 我们改变调用对象为People
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍老师";
    [anInvocation invokeWithTarget:cangTeacher];
}

@end
