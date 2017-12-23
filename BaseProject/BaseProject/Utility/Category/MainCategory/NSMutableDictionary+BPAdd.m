

//
//  NSMutableDictionary+BPAdd.m
//  CatergoryDemo
//
//  Created by xiaruzhen on 16/5/4.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "NSMutableDictionary+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(NSMutableDictionary_BPAdd)

typedef id(^BPWeakReferencesBlock)(void);

@implementation NSMutableDictionary (BPAdd)

- (void)bp_weakSetObject:(id)object key:(id<NSCopying>)key{
    if (!key) {
        return;
    }
    [self setObject:[self _bp_makeWeakReferencesObjectBlockWithObject:object] forKey:key];
}

- (void)bp_weakSetDictionary:(NSDictionary *)otherDictionary{
    if (!otherDictionary.count) {
        return;
    }
    [otherDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self setObject:[self _bp_makeWeakReferencesObjectBlockWithObject:obj] forKey:key];
    }];
}

- (id)bp_weakObjectForKey:(id<NSCopying>)key{
    BPWeakReferencesBlock weakReferencesObjectBlock = self[key];
    return weakReferencesObjectBlock ? weakReferencesObjectBlock() : nil;
}

- (BPWeakReferencesBlock)_bp_makeWeakReferencesObjectBlockWithObject:(id)object{
    if (!object) {
        return nil;
    }
    weakify(object);
    return ^(){
        strongify(object);
        return object;
    };
}

- (id)bp_popObjectForKey:(id)aKey {
    if (!aKey) return nil;
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

- (NSDictionary *)bp_popEntriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            [self removeObjectForKey:key];
            dic[key] = value;
        }
    }
    return dic;
}

@end
