//
//  UIScrollView+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIScrollView+BPAdd.h"

BPSYNTH_DUMMY_CLASS(UIScrollView_BPAdd)

@implementation UIScrollView (BPAdd)

- (void)bp_scrollToTop {
    [self bp_scrollToTopAnimated:YES];
}

- (void)bp_scrollToBottom {
    [self bp_scrollToBottomAnimated:YES];
}

- (void)bp_scrollToLeft {
    [self bp_scrollToLeftAnimated:YES];
}

- (void)bp_scrollToRight {
    [self bp_scrollToRightAnimated:YES];
}

- (void)bp_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)bp_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)bp_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)bp_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
