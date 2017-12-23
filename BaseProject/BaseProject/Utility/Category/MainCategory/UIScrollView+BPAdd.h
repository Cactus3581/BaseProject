//
//  UIScrollView+BPAdd.h
//  CatergoryDemo
//
//  Created by xiaruzhen on 16/5/17.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (BPAdd)

- (void)bp_scrollToTop;
- (void)bp_scrollToBottom;
- (void)bp_scrollToLeft;
- (void)bp_scrollToRight;
- (void)bp_scrollToTopAnimated:(BOOL)animated;
- (void)bp_scrollToBottomAnimated:(BOOL)animated;
- (void)bp_scrollToLeftAnimated:(BOOL)animated;
- (void)bp_scrollToRightAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
