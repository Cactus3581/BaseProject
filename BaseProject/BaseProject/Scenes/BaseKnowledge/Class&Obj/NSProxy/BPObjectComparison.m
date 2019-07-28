//
//  BPObjectComparison.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/6/26.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPObjectComparison.h"
#import "BPProxyModel.h"

@interface BPObjectComparison ()

@property (nonatomic,strong) id target;

@end


@implementation BPObjectComparison

#pragma mark - init
- (instancetype)initWithObj:(id)obj {
    self = [super init];
    if (self) {
        _target = obj;
    }
    return self;
}

#pragma mark - NSProxy override methods

// 快速转发：该方法在NSObject里，但是在NSProxy里可以执行，官方不建议重写这个方法
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _target; // 不走消息转发
    //    return nil; // 走下面的消息转发
}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
//    //检查target
//    if (_target && [_target respondsToSelector:sel]) {
//        return [_target methodSignatureForSelector:sel];
//    } else {
//        return [super methodSignatureForSelector:sel];
//    }
//}

//- (void)forwardInvocation:(NSInvocation *)invocation {
//    //获取当前选择子
//    SEL sel = invocation.selector;
//    //检查target
//    if (_target && [_target respondsToSelector:sel]) {
//        [invocation invokeWithTarget:_target];
//    } else {
//        [super forwardInvocation:invocation];
//    }
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_target isEqual:object];
}

- (NSUInteger)hash {
    return [_target hash];
}

- (Class)superclass {
    return [_target superclass];
}

- (Class)class {
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_target description];
}

- (NSString *)debugDescription {
    return [_target debugDescription];
}

@end
