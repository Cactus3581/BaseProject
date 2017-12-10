//
//  UIWebView+style.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JKStyle)
/**
 *  @brief  是否显示阴影
 *
 *  @param hidden 是否显示阴影
 */
- (void)bp_shadowViewHidden:(BOOL)hidden;

/**
 *  @brief  是否显示水平滑动指示器
 *
 *  @param hidden 是否显示水平滑动指示器
 */
- (void)bp_showsHorizontalScrollIndicator:(BOOL)hidden;
/**
 *  @brief  是否显示垂直滑动指示器
 *
 *  @param hidden 是否显示垂直滑动指示器
 */
- (void)bp_showsVerticalScrollIndicator:(BOOL)hidden;

/**
 *  @brief  网页透明
 */
-(void)bp_makeTransparent;
/**
 *  @brief  网页透明移除+阴影
 */
-(void)bp_makeTransparentAndRemoveShadow;
@end
