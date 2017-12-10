//
//  NSInvocation+Block.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSInvocation (JKBlock)
+ (instancetype)jk_invocationWithBlock:(id) block;
+ (instancetype)jk_invocationWithBlockAndArguments:(id) block ,...;
@end
