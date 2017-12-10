//
//  UIView+Shadow.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/9/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BPShadow)

- (void)configShadow:(UIColor *)color withOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;

- (void)configShadow:(UIColor *)color withOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity bezierPath:(UIBezierPath *)path;

@end

