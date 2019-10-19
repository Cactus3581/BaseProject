//
//  UIView+BPShadow.m
//  BaseProject
//
//  Created by Ryan on 2017/9/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+BPShadow.h"

@implementation UIView (BPShadow)

- (void)configShadow:(UIColor *)color withOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
}

#pragma mark - Configue path
- (void)configShadow:(UIColor *)color withOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity bezierPath:(UIBezierPath *)path {
    [self configShadow:color withOffset:offset radius:radius opacity:opacity];
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
}

@end
