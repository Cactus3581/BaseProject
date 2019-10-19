//
//  UIButton+BPSubmitting.h
//  BaseProject
//
//  Created by Ryan on 2017/12/6.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BPSubmitting)

/**
 *
 *  @brief  按钮点击后，禁用按钮并在按钮上显示ActivityIndicator
 *
 *  @param color 按钮上的颜色
 */
- (void)bp_beginSubmitting:(UIColor *)color;

/**
 *
 *  @brief  按钮点击后，恢复按钮点击前的状态
 */
- (void)bp_endSubmitting;

/**
 *
 *  @brief  按钮是否正在提交中
 */
@property(nonatomic, readonly, getter=isBPSubmitting) NSNumber *bp_submitting;

@end
