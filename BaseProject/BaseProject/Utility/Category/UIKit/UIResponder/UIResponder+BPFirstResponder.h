//
//  UIResponder+BPFirstResponder.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIResponder (BPFirstResponder)
/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)bp_currentFirstResponder;

@end
