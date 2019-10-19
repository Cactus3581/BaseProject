//
//  BPMulticastDelegate.m
//  BaseProject
//
//  Created by Ryan on 2019/7/28.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPMulticastDelegate.h"

@interface BPMulticastDelegate ()

@property (nonatomic,strong) dispatch_semaphore_t semaphore; // safe
@property (nonatomic, strong) NSHashTable *hashTable;

@end


@implementation BPMulticastDelegate

+ (id)alloc {
    BPMulticastDelegate *instance = [super alloc];
    if (instance) {
        instance.semaphore = dispatch_semaphore_create(1);
        // NSHashTable *hashTable = [NSHashTable weakObjectsHashTable];
        NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
        instance.hashTable = hashTable;

    }
    return instance;
}

- (void)setDelegate:(id)delegate {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    [_hashTable addObject:delegate];
    if (delegate) {
        // 重复设置delegate无效，因为set的缘故
        [_hashTable addObject:delegate];
    }
    dispatch_semaphore_signal(_semaphore);
}

- (void)removeDelegate:(id)delegate {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    [_hashTable removeObject:delegate];
    dispatch_semaphore_signal(_semaphore);
}

- (void)removeAllDelegate {
    [_hashTable removeAllObjects];
}

#pragma mark - 消息转发部分
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    NSMethodSignature *methodSignature;
    for (id delegate in _hashTable) {
        if ([delegate respondsToSelector:selector]) {
            methodSignature = [delegate methodSignatureForSelector:selector];
            break;
        }
    }

    dispatch_semaphore_signal(_semaphore);
    if (methodSignature){
        return methodSignature;
    }
    // 未找到方法时，返回默认方法 "- (void)method"，防止崩溃
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    // 为了避免造成递归死锁，copy一份delegates而不是直接用信号量将for循环包裹
    NSHashTable *copyDelegates = [_hashTable copy];
    dispatch_semaphore_signal(_semaphore);
    
    SEL selector = invocation.selector;
    
    [[copyDelegates allObjects] enumerateObjectsUsingBlock:^(id delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate respondsToSelector:selector]) {
            // 异步调用时，拷贝一个Invocation，以免意外修改target导致crash
            NSInvocation *dupInvocation = [self copyInvocation:invocation];
            dupInvocation.target = delegate;
            // 异步调用多代理方法，以免响应不及时
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [dupInvocation invoke];
            });
        }
    }];
}

- (NSInvocation *)copyInvocation:(NSInvocation *)invocation {
    SEL selector = invocation.selector;
    NSMethodSignature *methodSignature = invocation.methodSignature;
    NSInvocation *copyInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    copyInvocation.selector = selector;
    
    NSUInteger count = methodSignature.numberOfArguments;
    for (NSUInteger i = 2; i < count; i++) {
        void *value;
        [invocation getArgument:&value atIndex:i];
        [copyInvocation setArgument:&value atIndex:i];
    }
    [copyInvocation retainArguments];
    return copyInvocation;
}

@end
