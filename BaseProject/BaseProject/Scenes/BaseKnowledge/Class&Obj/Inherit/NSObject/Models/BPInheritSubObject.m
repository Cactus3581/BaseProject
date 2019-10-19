//
//  BPInheritSubObject.m
//  BaseProject
//
//  Created by Ryan on 2018/6/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPInheritSubObject.h"

@implementation BPInheritSubObject

+ (void)initialize {

}

- (instancetype)init {
    self = [super init];
    if (self) {
        BPLog(@"i'm sub init");
    }
    return self;
}

// A,A,B,C,c,d,f,
#pragma mark - 系统主动调用
- (void)methond_A {
    [super methond_A];
    BPLog(@"i'm sub a");
}

- (void)methond_B {
    BPLog(@"i'm sub b");
}

#pragma mark - 自己主动调用
- (void)methond_C {
    [super methond_C];
    BPLog(@"i'm sub c");
}

- (void)methond_D {
    BPLog(@"i'm sub d");
}

- (void)methond_f {
    BPLog(@"i'm sub f");
}

- (void)methond_Z {
    BPLog(@"i'm sub z");
}

#pragma mark - 子类重写，但是没有调用super，父类也会调用，奇怪
- (void)dealloc {
    BPLog(@"i'm sub dealloc");
}

@end
