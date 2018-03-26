//
//  BPDesignPatternsSingleClass.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsSingleClass.h"
//对象指针都是nil，NULL。
static BPDesignPatternsSingleClass *single = nil;

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

@end
