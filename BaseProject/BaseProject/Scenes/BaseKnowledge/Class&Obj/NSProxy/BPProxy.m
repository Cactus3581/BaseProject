//
//  BPProxy.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/6/26.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPProxy.h"
#import "BPProxyModel.h"

@interface BPProxy ()

@property (nonatomic,strong) id target;

@end


@implementation BPProxy

#pragma mark - init
- (instancetype)initWithObj:(id)obj {
    _target = obj;
    return self;
}

#pragma mark - NSProxy override methods

// 快速转发：该方法在NSObject里，但是在NSProxy里可以执行，官方不建议重写这个方法
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _target; // 不走消息转发
//    return nil; // 走下面的消息转发
}

- (void)execute1:(NSString *)text {
    NSLog(@"execute1 %@",text);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    //检查target
    if (_target && [_target respondsToSelector:sel]) {
        return [_target methodSignatureForSelector:sel];
    } else {
        return [super methodSignatureForSelector:sel];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    //获取当前选择子
    SEL sel = invocation.selector;
    //检查target
    if (_target && [_target respondsToSelector:sel]) {
        [invocation invokeWithTarget:_target];
    } else {
        [super forwardInvocation:invocation];
    }
}

@end
