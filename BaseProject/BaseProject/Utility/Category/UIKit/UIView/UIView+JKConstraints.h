//
//  UIView+JKConstraints.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (JKConstraints)
- (NSLayoutConstraint *)bp_constraintForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)bp_leftConstraint;
- (NSLayoutConstraint *)bp_rightConstraint;
- (NSLayoutConstraint *)bp_topConstraint;
- (NSLayoutConstraint *)bp_bottomConstraint;
- (NSLayoutConstraint *)bp_leadingConstraint;
- (NSLayoutConstraint *)bp_trailingConstraint;
- (NSLayoutConstraint *)bp_widthConstraint;
- (NSLayoutConstraint *)bp_heightConstraint;
- (NSLayoutConstraint *)bp_centerXConstraint;
- (NSLayoutConstraint *)bp_centerYConstraint;
- (NSLayoutConstraint *)bp_baseLineConstraint;
@end
