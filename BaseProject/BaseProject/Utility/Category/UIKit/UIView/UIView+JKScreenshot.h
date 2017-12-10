//
//  UIView+Screenshot.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKScreenshot)
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
