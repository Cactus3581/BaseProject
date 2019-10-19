//
//  UIScrollView+BPAddition.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIScrollView+BPAddition.h"

@implementation UIScrollView (Addition)
//frame
- (CGFloat)bp_contentWidth {
    return self.contentSize.width;
}
- (void)setBp_contentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (CGFloat)bp_contentHeight {
    return self.contentSize.height;
}
- (void)setBp_contentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}
- (CGFloat)bp_contentOffsetX {
    return self.contentOffset.x;
}
- (void)setBp_contentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}
- (CGFloat)bp_contentOffsetY {
    return self.contentOffset.y;
}
- (void)setBp_contentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}
//


- (CGPoint)bp_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)bp_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)bp_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)bp_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}
- (BPScrollDirection)bp_ScrollDirection
{
    BPScrollDirection direction;
    
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f)
    {
        direction = BPScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f)
    {
        direction = BPScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f)
    {
        direction = BPScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f)
    {
        direction = BPScrollDirectionRight;
    }
    else
    {
        direction = BPScrollDirectionWTF;
    }
    
    return direction;
}
- (BOOL)bp_isScrolledToTop
{
    return self.contentOffset.y <= [self bp_topContentOffset].y;
}
- (BOOL)bp_isScrolledToBottom
{
    return self.contentOffset.y >= [self bp_bottomContentOffset].y;
}
- (BOOL)bp_isScrolledToLeft
{
    return self.contentOffset.x <= [self bp_leftContentOffset].x;
}
- (BOOL)bp_isScrolledToRight
{
    return self.contentOffset.x >= [self bp_rightContentOffset].x;
}
- (void)bp_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self bp_topContentOffset] animated:animated];
}
- (void)bp_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self bp_bottomContentOffset] animated:animated];
}
- (void)bp_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self bp_leftContentOffset] animated:animated];
}
- (void)bp_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self bp_rightContentOffset] animated:animated];
}
- (NSUInteger)bp_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)bp_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}
- (void)bp_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)bp_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}


@end
