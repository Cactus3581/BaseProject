//
//  UIScrollView+BPAddition.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BPScrollDirection) {
    BPScrollDirectionUp,
    BPScrollDirectionDown,
    BPScrollDirectionLeft,
    BPScrollDirectionRight,
    BPScrollDirectionWTF
};

@interface UIScrollView (Addition)
@property(nonatomic) CGFloat bp_contentWidth;
@property(nonatomic) CGFloat bp_contentHeight;
@property(nonatomic) CGFloat bp_contentOffsetX;
@property(nonatomic) CGFloat bp_contentOffsetY;

- (CGPoint)bp_topContentOffset;
- (CGPoint)bp_bottomContentOffset;
- (CGPoint)bp_leftContentOffset;
- (CGPoint)bp_rightContentOffset;

- (BPScrollDirection)bp_ScrollDirection;

- (BOOL)bp_isScrolledToTop;
- (BOOL)bp_isScrolledToBottom;
- (BOOL)bp_isScrolledToLeft;
- (BOOL)bp_isScrolledToRight;
- (void)bp_scrollToTopAnimated:(BOOL)animated;
- (void)bp_scrollToBottomAnimated:(BOOL)animated;
- (void)bp_scrollToLeftAnimated:(BOOL)animated;
- (void)bp_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)bp_verticalPageIndex;
- (NSUInteger)bp_horizontalPageIndex;

- (void)bp_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)bp_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
@end
