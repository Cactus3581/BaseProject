//
//  BPSwizzlingParent.m
//  BaseProject
//
//  Created by Ryan on 2019/1/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSwizzlingParent.h"

@implementation BPSwizzlingParent

- (void)foo {
    NSLog(@"%@ 父类 原始IMP",[self class]);
}

+ (void)foo {
    NSLog(@"%@ 父类 原始IMP",[self class]);
}

@end
