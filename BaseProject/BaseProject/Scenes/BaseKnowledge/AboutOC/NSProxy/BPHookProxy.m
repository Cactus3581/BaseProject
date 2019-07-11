//
//  BPHookProxy.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/6/26.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHookProxy.h"
#import "BPProxyModel.h"

@interface BPHookProxy ()

@property (nonatomic,strong) id target;

@end


@implementation BPHookProxy

- (instancetype)initWithObj:(id)obj {
    _target = obj;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    // 这里可以返回任何 NSMethodSignature 对象，也可以完全自己构造一个
    return [_target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if([_target respondsToSelector:invocation.selector]){
        NSString *selectorName = NSStringFromSelector(invocation.selector);
        NSLog(@"Before calling %@",selectorName);
        [invocation retainArguments];
        NSMethodSignature *sig = [invocation methodSignature];
        // 获取参数个数，注意在本例里这里的值是 3，因为 objc_msgSend 隐含了 self、selector 参数
        NSUInteger cnt = [sig numberOfArguments];
        // 本例只是简单的将参数和返回值打印出来
        for (int i = 0; i < cnt; i++) {
            // 参数类型
            const char * type = [sig getArgumentTypeAtIndex:i];
            if(strcmp(type, "@") == 0){
                NSObject *obj;
                [invocation getArgument:&obj atIndex:i];
                // 这里输出的是："parameter (0)'class is MyProxy"，也证明了这是 objc_msgSend 的第一个参数
                NSLog(@"parameter (%d)'class is %@", i, [obj class]);
            }
            else if(strcmp(type, ":") == 0){
                SEL sel;
                [invocation getArgument:&sel atIndex:i];
                // 这里输出的是:"parameter (1) is barking:"，也就是 objc_msgSend 的第二个参数
                NSLog(@"parameter (%d) is %@", i, NSStringFromSelector(sel));
            }
            else if(strcmp(type, "q") == 0){
                int arg = 0;
                [invocation getArgument:&arg atIndex:i];
                // 这里输出的是:"parameter (2) is int value is 4"，稍后会看到我们在调用 barking 的时候传递的参数就是 4
                NSLog(@"parameter (%d) is int value is %d", i, arg);
            }
        }
        // 消息转发
        [invocation invokeWithTarget:_target];
        const char *retType = [sig methodReturnType];
        if(strcmp(retType, "@") == 0){
            NSObject *ret;
            [invocation getReturnValue:&ret];
            //这里输出的是:"return value is wang wang!"
            NSLog(@"return value is %@", ret);
        }
        NSLog(@"After calling %@", selectorName);
    }
}

@end
