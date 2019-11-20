//
//  BPSwizzlingParent+BPSwizzling.m
//  BaseProject
//
//  Created by Ryan on 2019/1/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSwizzlingParent+BPSwizzling.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+BPSwizzling.h"

@implementation BPSwizzlingParent (BPSwizzling)

/*
 1. 加载分类到内存的时候调用
 2. load执行顺序：父主类 -> 子主类 -> 父类的分类加载会早于/晚于子类的分类的加载，这取决于编译的顺序
*/
+ (void)load {    
    
    // 虽然+load方法在类被加载的时候只会调用一次，还需要dispatch_once防止手动调用+load方法而导致反复的被交换
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 还有的将下面的类方法改为全局静态方法，不知道为什么？
        [self bp_swizzleInstanceMethodWithClass:[self class] originalSelector:@selector(foo) swizzledSelector:@selector(p_foo)];
    });
}
/*
 1. 不能在分类中重写方法foo，因为会把系统的功能给覆盖掉；
 2. 分类中不能调用super
 3. 最好调用原始实现
 */
- (void)p_foo {
    [self p_foo];// 这里调用p_foo，p_foo的imp为foo，相当于调用foo
    NSLog(@"%@ 主分 newIMP",[self class]);
}

@end
