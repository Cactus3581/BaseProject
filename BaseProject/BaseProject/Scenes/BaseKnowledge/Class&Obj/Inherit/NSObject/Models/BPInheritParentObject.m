//
//  BPInheritParentObject.m
//  BaseProject
//
//  Created by Ryan on 2018/6/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPInheritParentObject.h"

@implementation BPInheritParentObject
@synthesize offset = _offset;

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

#pragma mark - 子类拿不到，子类无法使用
- (void)methond_X {
    BPLog(@"i'm parent X");
    [self methond_Y];
    [self methond_Z];
}

- (void)methond_Y {
    BPLog(@"i'm parent Y");
}

- (void)methond_Z {
    BPLog(@"i'm parent Z");
}

#pragma mark - 子类重写，但是没有调用super，父类也会调用，奇怪
- (void)dealloc {
    BPLog(@"i'm parent dealloc");
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset;
}

- (CGFloat)offset {
    return _offset;
}

@end
