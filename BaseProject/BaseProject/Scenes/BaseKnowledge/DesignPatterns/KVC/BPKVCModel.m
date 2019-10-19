//
//  BPKVCModel.m
//  BaseProject
//
//  Created by Ryan on 2017/4/7.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPKVCModel.h"

@interface BPKVCModel()

@property (nonatomic,copy) NSString *privateIvar;

@end


@implementation BPKVCModel

#pragma mark - 四个 getter 方法
//- (NSString *)getNormalKey {
//    return [NSString stringWithFormat:@"%s", __func__];
//}
//
//- (NSString *)normalKey {
//    return [NSString stringWithFormat:@"%s", __func__];
//}
//
//- (NSString *)isNormalKey {
//    return [NSString stringWithFormat:@"%s", __func__];
//}
//
//- (NSString *)_normalKey {
//    return [NSString stringWithFormat:@"%s", __func__];
//}

#pragma mark - KVC开关


//默认返回YES，表示如果没有找到SetKey方法的话，会按照_key，_iskey，key，iskey的顺序搜索成员，设置成NO就不这样搜索：当KVC找不到setNormalKey：方法后，不再去找key系列成员变量，而是直接调用setValue：forUndefinedKey：方法。
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

#pragma mark - 异常
// 如果dic里面的有不存在于model中的元素会触发；当字典中的键，在对象属性中找不到对应的属性的时候会报错。
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    /*
    if ([key isEqualToString:@"id"]) {
        _userId = [value integerValue];
    }
     */
    BPLog(@"出现异常，key:%@ 不存在",key);
}

//如果Key不存在，且没有KVC无法搜索到任何和Key有关的字段或者属性，则会调用这个方法，默认是抛出异常。
- (nullable id)valueForUndefinedKey:(NSString *)key {
    BPLog(@"出现异常，key:%@ 不存在",key);
    return nil;
}

// 当通过setValue给某个非对象的属性赋值为nil时，则会调用这个方法
- (void)setNilValueForKey:(NSString *)key {
    BPLog(@"setNilValueForKey:%@",key);
    if ([key isEqualToString:@"intKey"]) {
        [self setValue:@(0) forKey:@"intKey"];
    }else{
        [super setNilValueForKey:key];
    }
}

#pragma mark - 验证Value

// 验证key对应的Value是否可用，为不可用或者正确的值做一个替换值或者拒绝设置新值并返回错误原因。
- (BOOL)validateValue:(inout id __nullable * __nonnull)ioValue forKey:(NSString *)inKey error:(out NSError **)outError {
    
    // 默认返回YES
    if ([inKey isEqualToString:NSStringFromSelector(@selector(normalKey))]) {
        
        // 条件一
        NSString *normalKey = *ioValue;
        normalKey = normalKey.capitalizedString;
        if ([normalKey isEqualToString:@"numberKey"]) {
            //如果value是numberKey，就返回NO，这里省略了错误提示
            return NO;
        }
        
        // 条件二
        if (*ioValue != nil) { //如果value不等于nil，就返回yes，这里省略了错误提示
            return YES;
        } else {
            return NO;
        }
    }
    return [super validateValue:ioValue forKey:inKey error:outError];
}

#pragma mark -（看KVPModel里的实现）集合操作的API，包括NSSet和NSDictionary，配合KVO才有勇敢

// 如果属性是一个NSMutableArray，那么可以用这个方法来返回。

- (NSMutableArray *)mutableArrayValueForKey:(NSString *)key {
    return [super mutableArrayValueForKey:key];
}

- (NSMutableOrderedSet *)mutableOrderedSetValueForKey:(NSString *)key {
    return [super mutableOrderedSetValueForKey:key];
}

- (NSMutableSet *)mutableSetValueForKey:(NSString *)key {
    return [super mutableSetValueForKey:key];
}

@end


@implementation BPKVCSubModel

@end
