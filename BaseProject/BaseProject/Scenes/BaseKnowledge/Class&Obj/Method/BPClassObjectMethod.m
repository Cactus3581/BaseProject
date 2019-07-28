//
//  BPClassObjectMethod.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/24.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPClassObjectMethod.h"

//https://www.jianshu.com/p/21997f7f1e95

@implementation BPClassObjectMethod

#pragma mark - 何时用静态方法，何时用类方法？

/*
 
 实例方法： 当你给一个类写一个方法，如果该方法需要访问某个实例的成员变量时，那么方法该被定义为实例方法。 一个类的实例通常有一些成员变量，其中含有该实例的状态信息。而该方法需要改变这些状态，那么该方法需要声明成实例方法
 
 类方法（静态方法）：它不需要访问某个实例的成员变量，不需要改变某个实例的状态，我们把该方法定义为静态方法。
 */

#pragma mark - 工厂方法/类方法/静态方法/便利构造器

#pragma mark - super与self
/*
 类方法中的self:
 在整个程序运行过程中，一个类有且仅有一个类对象。
 通过类名调用方法就是给这个类对象发送消息。
 类方法的self就是这个类对象
 在类方法中可以通过self来调用其他的类方法
 不能在类方法中去调用对象方法或成员变量，因为对象方法与成员变量都是属于具体的实例对象的。
 */
- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - self 在对象方法和类方法的含义：对象的首地址，该对象可以是实例对象也可以是类对象
+ (void) classMethod {
    BPLog(@"classMethod");

    [self classMethod_1];
    
    BPClassObjectMethod *objc = [[BPClassObjectMethod alloc] init];
    objc.title = @"ClassObject";
    //self.title = @"ClassObject";
    //[self objcMethod]
}

- (void)objcMethod {
    BPLog(@"objcMethod");
    self.title = @"ClassObject";
}

+ (void)classMethod_1 {
    BPLog(@"classMethod_1");
}

@end
