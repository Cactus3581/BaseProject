//
//  BPKVOModel.m
//  BaseProject
//
//  Created by Ryan on 2019/1/8.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPKVOModel.h"

@implementation BPKVOModel

@dynamic testDynamic;

- (instancetype)init {
    self = [super init];
    if (self) {
        BPKVODependModel *dependModel = [[BPKVODependModel alloc] init];
        _dependModel = dependModel;
    }
    return self;
}

#pragma mark - 手动触发ivar的KVO
- (void)changeIphone:(NSString *)testNormalIvar {
    [self willChangeValueForKey:@"testNormalIvar"];
    _testNormalIvar = testNormalIvar; // 如果注释调，也会触发KVO，但是new值不会变。
    [self didChangeValueForKey:@"testNormalIvar"];
}

#pragma mark - 手动触发
- (void)setTestRepeatKVO:(NSString *)testRepeatKVO {
    [self willChangeValueForKey:@"testRepeatKVO"];
    _testRepeatKVO = testRepeatKVO;
    [self didChangeValueForKey:@"testRepeatKVO"];
}

#pragma mark - 手动实现ivar的setter方法
- (void)setManualImplementSetterIvar:(NSString *)manualImplementSetterIvar {
    _manualImplementSetterIvar = manualImplementSetterIvar;
}

#pragma mark - KVO开关
//控制是否自动发送通知，如果返回NO，KVO无法自动运作，需手动触发。
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    // 如果监测到键值为iphone,则指定为非自动监听对象
    if ([key isEqualToString:@"testForbidLock"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

#pragma mark - 依赖KVO

- (void)setDependProperty:(NSString *)dependProperty {
    _dependModel.dependProperty1 = dependProperty;
    _dependModel.dependProperty2 = dependProperty;
}

- (NSString *)dependProperty {
    return [[NSString alloc] initWithFormat:@"%@+%@",_dependModel.dependProperty1, _dependModel.dependProperty2];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    NSArray *moreKeyPaths = nil;
    if ([key isEqualToString:@"dependProperty"]) {
        moreKeyPaths = [NSArray arrayWithObjects:@"dependModel.dependProperty1", @"dependModel.dependProperty2", nil];
    }
    if (moreKeyPaths) {
        keyPaths = [keyPaths setByAddingObjectsFromArray:moreKeyPaths];
    }
    return keyPaths;
}

+ (NSSet *)keyPathsForValuesAffectingInformation {
    NSSet *keyPaths = [NSSet setWithObjects:@"dependModel.dependProperty1",@"dependModel.dependProperty2",nil];
    return keyPaths;
}

#pragma mark - 以下是KVC的方法。集合操作的API，包括NSSet和NSDictionary，配合KVO才有勇敢

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
