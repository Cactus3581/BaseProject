//
//  BPDesignPatternsSingleClass.m
//  BaseProject
//
//  Created by Ryan on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsSingleClass.h"

#pragma mark - 下面是苹果官方的单例写法：

static BPDesignPatternsSingleClass *single = nil;

@interface BPDesignPatternsSingleClass()

@end


@implementation BPDesignPatternsSingleClass

+ (BPDesignPatternsSingleClass *)shareSingleClass {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[BPDesignPatternsSingleClass alloc]init];
    });
    return single;
}

+ (BPDesignPatternsSingleClass *)shareSingleClassB {
    @synchronized(self){
        if (single == nil) {
            single = [[BPDesignPatternsSingleClass alloc]init];
        }
        return single;
    }
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (single == nil) {
            single = [super allocWithZone:zone];
            return single;  // assignment and return on first allocation
        }
    }
    return nil; 
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - MRC下
/*
- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}
*/

@end
