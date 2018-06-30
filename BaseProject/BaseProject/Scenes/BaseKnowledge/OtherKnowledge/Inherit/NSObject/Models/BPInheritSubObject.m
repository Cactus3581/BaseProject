//
//  BPInheritSubObject.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPInheritSubObject.h"

@implementation BPInheritSubObject

- (instancetype)init {
    self = [super init];
    if (self) {
        BPLog(@"i'm sub init");
    }
    return self;
}

#pragma mark - 系统主动调用
- (void)methond_A {
    [super methond_A];
    BPLog(@"i'm sub A");
}

- (void)methond_B {
    BPLog(@"i'm sub B");
}

#pragma mark - 自己主动调用
- (void)methond_C {
    [super methond_C];
    BPLog(@"i'm sub C");
}

- (void)methond_D {
    BPLog(@"i'm sub D");
}

- (void)methond_f {
    BPLog(@"i'm sub f");
}

#pragma mark - 子类重写，但是没有调用super，父类也会调用，奇怪
- (void)dealloc {
    BPLog(@"i'm sub dealloc");
}

@end
