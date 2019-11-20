//
//  NSArray+BPSafe.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSArray+BPSafe.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+BPSwizzling.h"


@implementation NSArray (BPSafe)

+ (void)load {
    
    Class class = NSClassFromString(@"__NSArrayI");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    });
}

// 检查是否越界和NSNull如果是返回nil
- (id)bp_objectAtIndexCheck:(NSUInteger)index {
    
    if (index >= [self count]) {
        BPLog(@"%ld is outof rang",(long)index);
        return nil;
    }
    
    id value;
    if ([self objectAtIndex:index]) {
       value = [self objectAtIndex:index];
    }
    
    if (value == [NSNull null]) {
        BPLog(@"%ld is [NSNull null]",(long)index);
        return nil;
    }
    
    return value;
}

@end

@implementation NSMutableArray (BPSafe)

+ (void)load {
        
    Class class = NSClassFromString(@"__NSArrayM");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self bp_swizzleInstanceMethodWithClass:class originalSelector:@selector(insertObject:atIndex:) swizzledSelector:@selector(bp_insertObject:atIndex:)];
        [self bp_swizzleInstanceMethodWithClass:class originalSelector:@selector(arrayWithObjects:count:) swizzledSelector:@selector(bp_arrayWithObjects:count:)];
        [self bp_swizzleInstanceMethodWithClass:class originalSelector:@selector(setObject:atIndex:) swizzledSelector:@selector(bp_setObject:atIndex:)];
    });
    
}

- (void)bp_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        return;
    }
    [self bp_insertObject:anObject atIndex:index];
}

- (void)bp_setObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        return;
    }
    [self bp_setObject:anObject atIndex:index];
}

+ (instancetype)bp_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {
    id nObjects[cnt];
    int i = 0, j = 0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i]) {
            nObjects[j] = objects[i];
            j++;
        }
    }
    return [self bp_arrayWithObjects:nObjects count:j];
}

@end
