//
//  People+Associated.m
//  BaseProject
//
//  Created by Ryan on 2018/12/6.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "People+Associated.h"
#import <objc/runtime.h>
#import <objc/message.h>

static const char *phoneNumberKey = "phoneNumber";

@implementation People (Associated)

//@synthesize unfinishIvar = _unfinishIvar;
@dynamic unfinishIvar; // @dynamic语义是在编译期不要自动创建实现属性所用的存取方法。不写这个关键字，使用同名方法进行override也是可以达到相同效果的。但从编码规范和优化效率来讲，显式声明是最好的。

- (NSNumber *)associatedBust {
    // 得到关联对象
    return objc_getAssociatedObject(self, @selector(associatedBust));
}

- (void)setAssociatedBust:(NSNumber *)bust {
    // 设置关联对象
    objc_setAssociatedObject(self, @selector(associatedBust), bust, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CodingCallBack)associatedCallBack {
    return objc_getAssociatedObject(self, @selector(associatedCallBack));
}

- (void)setAssociatedCallBack:(CodingCallBack)callback {
    objc_setAssociatedObject(self, @selector(associatedCallBack), callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)phoneNumber {
    return [objc_getAssociatedObject(self, phoneNumberKey) integerValue];
}

- (void)setPhoneNumber:(NSInteger)phoneNumber {
    /*
     第一个参数：给哪个对象添加关联
     
     第二个参数：关联的key，通过这个key获取，key：要保证全局唯一，通常用@selector(methodName)作为key。
     至此，设置关联对象关键key，一共有三种写法:
     1. 静态变量&btnKey
     2. @selector(methodName)
     3. _cmd
    
    第四个参数有五种关联策略：
    OBJC_ASSOCIATION_ASSIGN             等价于 @property(assign)。
    OBJC_ASSOCIATION_RETAIN_NONATOMIC   等价于 @property(strong, nonatomic)。
    OBJC_ASSOCIATION_COPY_NONATOMIC     等价于@property(copy, nonatomic)。
    OBJC_ASSOCIATION_RETAIN             等价于@property(strong,atomic)。
    OBJC_ASSOCIATION_COPY               等价于@property(copy, atomic)。
     */
    
    objc_setAssociatedObject(self, phoneNumberKey, @(phoneNumber), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setUnfinishIvar:(NSString *)unfinishIvar {
}

- (NSString *)unfinishIvar {
    return nil;
}

@end
