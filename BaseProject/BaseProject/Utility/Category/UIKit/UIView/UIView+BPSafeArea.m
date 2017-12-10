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
    CGFloat value = BPCustomNaviHeight(self);
    if (value != constraint.constant) {
        constraint.constant = value;
    }
}

- (void)updateHomeBarBottomWithConstraint:(NSLayoutConstraint *)constraint {
    CGFloat value = BPHomeBarBottom(self);
    if (value != constraint.constant) {
        constraint.constant = value;
    }
}

- (void)updateStatusBarHeightWithConstraint:(NSLayoutConstraint *)constraint {
    CGFloat value = BPStatusBarHeight(self);
    if (value != constraint.constant) {
        constraint.constant = value;
    }
}

- (void)updateViewCenterYInNaviWithConstraint:(NSLayoutConstraint *)constraint {
    CGFloat value = BPViewCenterYInNavi(self);
    if (value != constraint.constant) {
        constraint.constant = value;
    }
}

@end
