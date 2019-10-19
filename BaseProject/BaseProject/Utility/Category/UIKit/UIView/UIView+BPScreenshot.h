//
//  UIView+BPScreenshot.h
//  BaseProject
//
//  Created by Ryan on 2017/11/9.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BPScreenshot)

- (UIImage*)beginImageContext:(CGRect)rect View:(UIView*)view;

#pragma mark - 图片相关操作
- (UIImage *)screenshotWithTopView:(UIView *)topView bottomView:(UIView *)bottomView;

#pragma mark -  截图功能
- (UIImage*)captureView:(UIView *)theView;

#pragma mark - 拼接图片
- (UIImage *)composeWithTopImage:(UIImage *)top bottomImage:(UIImage *)bottom;

/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)bp_screenshot;

/**
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param maxWidth 限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)bp_screenshot:(CGFloat)maxWidth;

@end
