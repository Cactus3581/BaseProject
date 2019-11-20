//
//  NSDictionary+BPSafe.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSDictionary+BPSafe.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+BPSwizzling.h"

@implementation NSDictionary (BPSafe)

+ (void)load {
    Class class = [self class];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self bp_swizzleInstanceMethodWithClass:class originalSelector:@selector(dictionaryWithObjects:forKeys:count:) swizzledSelector:@selector(bp_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)bp_dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt {
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i] && keys[i]) {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }
    return [self bp_dictionaryWithObjects:nObjects forKeys:nKeys count:j];
}

@end


@implementation NSMutableDictionary (BPSafe)

+ (void)load {
    Class class = NSClassFromString(@"__NSDictionaryM");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self bp_swizzleInstanceMethodWithClass:class originalSelector:@selector(setObject:forKey:) swizzledSelector:@selector(bp_setObject:forKey:)];
    });
}

- (void)bp_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject) {
        [self bp_setObject:anObject forKey:aKey];
    }else{
        BPLog(@"key:%@ anobj is nil \n",aKey);
    }
}

@end
