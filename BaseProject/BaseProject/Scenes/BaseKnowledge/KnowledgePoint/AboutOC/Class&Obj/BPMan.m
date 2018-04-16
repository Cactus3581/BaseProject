//
//  BPMan.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMan.h"

@implementation BPMan

/*
 1.super self
 self 谁调用方法， 那么self就是谁，在－方法也就是对象方法中，self指的就是当前类对象，在＋方法也就是类方法中，self指的就是当前的类。
 super是一个指令，调用父类方法的实现，不是父类对象
 */

- (void)sayHi {
    [super sayHi];
    BPLog(@"%p",&self);
}

@end
