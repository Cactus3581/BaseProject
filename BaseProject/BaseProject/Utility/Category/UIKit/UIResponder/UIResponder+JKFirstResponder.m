//
//  UIResponder+FirstResponder.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIResponder+JKFirstResponder.h"

static __weak id bp_currentFirstResponder;

@implementation UIResponder (JKFirstResponder)
/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)bp_currentFirstResponder {
    bp_currentFirstResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(bp_findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    
    return bp_currentFirstResponder;
}

- (void)bp_findCurrentFirstResponder:(id)sender {
    bp_currentFirstResponder = self;
}

@end
