//
//  UIView+BPSafeArea.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/6.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+BPSafeArea.h"

@implementation UIView (BPSafeArea)

- (void)updateNaviHeightWithConstraint:(NSLayoutConstraint *)constraint {
    CGFloat value = BPSafeAreaCustomNaviHeight(self);
    if (value != constraint.constant) {
        constraint.constant = value;
    }
}

- (void)updateHomeBarBottomWithConstraint:(NSLayoutConstraint *)constraint {
    CGFloat value = BPSafeAreaHomeBarBottom(self);
    if (value != constraint.constant) {
        constraint.constant = value;
    }
}

- (void)updateStatusBarHeightWithConstraint:(NSLayoutConstraint *)constraint {
    CGFloat value = BPSafeAreaStatusBarHeight(self);
    if (value != constraint.constant) {
        constraint.constant = value;
    }
}

- (void)updateViewCenterYInNaviWithConstraint:(NSLayoutConstraint *)constraint {
    CGFloat value = BPSafeAreaViewCenterYInNavi(self);
    if (value != constraint.constant) {
        constraint.constant = value;
    }
}

@end
