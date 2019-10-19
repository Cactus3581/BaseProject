//
//  NSObject+BPCustomKVC.m
//  BaseProject
//
//  Created by Ryan on 2019/8/4.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "NSObject+BPCustomKVC.h"
#import <objc/runtime.h>
#import <objc/message.h>

/*
 
 省略了自定义KVC抛出异常的方法，省略了部分KVC搜索key的步骤，而且也许apple也许并不是这么做的。
 
 */

@implementation NSObject (BPCustomKVC)

- (void)bp_setValue:(id)value forKey:(NSString *)key {
    
    if (key == nil || key.length == 0) {  //key名要合法
        return;
    }
    
    if ([value isKindOfClass:[NSNull class]]) {
        [self setNilValueForKey:key]; //如果需要完全自定义，那么这里需要写一个bp_setNilValueForKey，但是必要性不是很大，就省略了
        return;
    }
    
    if (![value isKindOfClass:[NSObject class]]) {
        @throw @"must be s NSObject type";
        return;
    }
    
    //  先走setter方法
    NSString *funcName = [NSString stringWithFormat:@"set%@:",key.capitalizedString];
    if ([self respondsToSelector:NSSelectorFromString(funcName)]) {  //默认优先调用set方法
        [self performSelector:NSSelectorFromString(funcName) withObject:value];
        return;
    }
    
    unsigned int count;
    BOOL flag = false;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (NSInteger i = 0; i<count; i++) {
        Ivar var = vars[i];
        NSString* keyName = [[NSString stringWithCString:ivar_getName(var) encoding:NSUTF8StringEncoding] substringFromIndex:1];
        
        // _key
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
            flag = true;
            object_setIvar(self, var, value);
            break;
        }
        
        // key
        if ([keyName isEqualToString:key]) {
            flag = true;
            object_setIvar(self, var, value);
            break;
        }
    }
    if (!flag) {
        [self setValue:value forUndefinedKey:key];//如果需要完全自定义，那么这里需要写一个self bp_setValue:value forUndefinedKey:key，但是必要性不是很大，就省略了
    }
}

- (id)bp_valueforKey:(NSString *)key {
    
    if (key == nil || key.length == 0) {
        return [NSNull new]; //其实不能这么写的
    }
    
    // 这里为了方便，省略了集合的方法查询了
    NSString* funcName = [NSString stringWithFormat:@"gett%@:",key.capitalizedString];
    if ([self respondsToSelector:NSSelectorFromString(funcName)]) {
        return [self performSelector:NSSelectorFromString(funcName)];
    }
    
    unsigned int count;
    BOOL flag = false;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (NSInteger i = 0; i<count; i++) {
        Ivar var = vars[i];
        NSString* keyName = [[NSString stringWithCString:ivar_getName(var) encoding:NSUTF8StringEncoding] substringFromIndex:1];
        
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
            flag = true;
            return     object_getIvar(self, var);
            break;
        }
        
        if ([keyName isEqualToString:key]) {
            flag = true;
            return object_getIvar(self, var);
            break;
        }
    }
    
    if (!flag) {
        [self valueForUndefinedKey:key];//如果需要完全自定义，那么这里需要写一个self bp_valueForUndefinedKey，但是必要性不是很大，就省略了
    }
    return [NSNull new]; //其实不能这么写的
}

@end
