//
//  BPKVCModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/4/7.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPKVCModel.h"

@implementation BPKVCSubModel
@end

@implementation BPKVCModel

//默认返回YES，表示如果没有找到SetKey方法的话，会按照_key，_iskey，key，iskey的顺序搜索成员，设置成NO就不这样搜索：当KVC找不到setName：方法后，不再去找key系列成员变量，而是直接调用setValue：forUndefinedKey：方法。
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    BPLog(@"出现异常，该key不存在%@",key);
}

//如果Key不存在，且没有KVC无法搜索到任何和Key有关的字段或者属性，则会调用这个方法，默认是抛出异常。
- (nullable id)valueForUndefinedKey:(NSString *)key {
    BPLog(@"出现异常，该key不存在%@",key);
    return nil;
}

/*
 //KVC提供属性值正确性验证的API，它可以用来检查set的值是否正确、为不正确的值做一个替换值或者拒绝设置新值并返回错误原因。
 - (BOOL)validateValue:(inout id __nullable * __nonnull)ioValue forKey:(NSString *)inKey error:(out NSError **)outError {
 }

 //这是集合操作的API，里面还有一系列这样的API，如果属性是一个NSMutableArray，那么可以用这个方法来返回。
 - (NSMutableArray *)mutableArrayValueForKey:(NSString *)key {
 }

 //如果你在SetValue方法时面给Value传nil，则会调用这个方法
 - (void)setNilValueForKey:(NSString *)key {
 }

 //输入一组key,返回该组key对应的Value，再转成字典返回，用于将Model转到字典。
 - (NSDictionary<NSString *, id> *)dictionaryWithValuesForKeys:(NSArray<NSString *> *)keys {
 }
*/

@end
