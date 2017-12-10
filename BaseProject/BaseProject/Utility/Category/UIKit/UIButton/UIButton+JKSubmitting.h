
//
//  UIButton+Submitting.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JKSubmitting)

/**
 *
 *  @brief  按钮点击后，禁用按钮并在按钮上显示ActivityIndicator，以及title
 *
 *  @param title 按钮上显示的文字
 */
- (void)bp_beginSubmitting:(NSString *)title;

/**
 *
 *  @brief  按钮点击后，恢复按钮点击前的状态
 */
- (void)bp_endSubmitting;

/**
 *
 *  @brief  按钮是否正在提交中
 */
@property(nonatomic, readonly, getter=isJKSubmitting) NSNumber *bp_submitting;

@end
