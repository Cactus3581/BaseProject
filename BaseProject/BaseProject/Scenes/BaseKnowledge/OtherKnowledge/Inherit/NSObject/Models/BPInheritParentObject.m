//
//  BPInheritParentObject.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPInheritParentObject.h"

@implementation BPInheritParentObject

- (instancetype)init {
    self = [super init];
    if (self) {
        BPLog(@"i'm parent init");
        [self methond_A];
        [self methond_B];
    }
    return self;
}

#pragma mark - 系统主动调用
- (void)methond_A {
    BPLog(@"i'm parent A");
}

- (void)methond_B {
    BPLog(@"i'm parent B");
}

#pragma mark - 自己主动调用
- (void)methond_C {
    BPLog(@"i'm parent C");
}

- (void)methond_D {
    BPLog(@"i'm parent C");
}

#pragma mark - 子类拿不到，子类无法使用
- (void)methond_E {
    BPLog(@"i'm parent E");
}

@end
