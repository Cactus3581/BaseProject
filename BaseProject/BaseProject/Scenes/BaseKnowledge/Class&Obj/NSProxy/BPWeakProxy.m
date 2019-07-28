//
//  BPWeakProxy.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/6/26.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPWeakProxy.h"
#import "BPProxyModel.h"

@interface BPWeakProxy ()

@property (nullable, nonatomic, weak, readonly) id target;

@end


@implementation BPWeakProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

#pragma mark - private

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

#pragma mark - over write

//需要重载以下两个方法的原因：因为_target是弱引用的,所以当_target可能释放了,当它被释放了的情况下，那么forwardingTargetForSelector就是返回nil了，然后methodSignatureForSelector和forwardInvocation没实现的话，就直接crash了。
// 以下两个方法是为了防止crash随便写的，还是别有深意？

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *sel = [NSObject instanceMethodSignatureForSelector:@selector(init)];
    return sel;
}

//重写NSProxy如下两个方法，在处理消息转发时，将消息转发给真正的Target处理
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    // 设置返回值。
    [invocation setReturnValue:&null];
    // 获取返回值
//  [invocation getReturnValue:&null];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

#pragma mark - <NSObject>

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
