//
//  BPInheritParentObject.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPInheritParentObject.h"

@implementation BPInheritParentObject

+ (void)initialize {
    if (self == [BPInheritParentObject class]) {
        BPLog(@"initialize = %@ ",self);
    }
}

- (instancetype)init {
    self = [super init];
    BPLog(@"i'm = %@ ",self);
    if (self) {
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
    BPLog(@"i'm parent D");
}

#pragma mark - 子类拿不到，子类无法使用
- (void)methond_E {
    BPLog(@"i'm parent E");
}

#pragma mark - 子类重写，但是没有调用super，父类也会调用，奇怪
- (void)dealloc {
    BPLog(@"i'm parent dealloc");
}

@end
