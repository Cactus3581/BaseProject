//
//  NSObject+Propery.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/16.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "NSObject+Propery.h"
#import <objc/runtime.h>

// 定义关联的key
static const char *key = "name";
@implementation NSObject (Propery)

- (NSString *)name {
    // 根据关联的key，获取关联的值。
    return objc_getAssociatedObject(self, key);
}

- (void)setName:(NSString *)name {
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
