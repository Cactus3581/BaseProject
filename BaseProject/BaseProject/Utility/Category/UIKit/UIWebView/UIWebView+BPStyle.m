//
//  UIWebView+style.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIWebView+BPStyle.h"

@implementation UIWebView (BPStyle)
/**
 *  @brief  是否显示阴影
 *
 *  @param b 是否显示阴影
 */
- (void)bp_shadowViewHidden:(BOOL)hidden{
    for (UIView *aView in [self subviews])
    {
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:NO];
            for (UIView *shadowView in aView.subviews)
            {
                if ([shadowView isKindOfClass:[UIImageView class]])
                {
                    shadowView.hidden = hidden;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
}
/**
 *  @brief  是否显示水平滑动指示器
 *
 *  @param b 是否显示水平滑动指示器
 */
- (void)bp_showsHorizontalScrollIndicator:(BOOL)hidden{
    for (UIView *aView in [self subviews])
    {
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:hidden];
        }
    }
}
/**
 *  @brief  是否显示垂直滑动指示器
 *
 *  @param b 是否显示垂直滑动指示器
 */
- (void)bp_showsVerticalScrollIndicator:(BOOL)hidden{
    for (UIView *aView in [self subviews])
    {
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:hidden];
        }
    }
}
/**
 *  @brief  网页透明
 */
- (void)bp_makeTransparent
{
    self.backgroundColor = kClearColor;
    self.opaque = NO;
}
/**
 *  @brief  网页透明移除阴影
 */
- (void)bp_makeTransparentAndRemoveShadow
{
    [self bp_makeTransparent];
    [self bp_shadowViewHidden:YES];
}
@end
