//
//  NSInvocation+Block.h
//  BaseProject
//
//  Created by Ryan on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSInvocation (BPBlock)
+ (instancetype)_invocationWithBlock:(id) block;
+ (instancetype)_invocationWithBlockAndArguments:(id) block ,...;
@end
