//
//  UIColor+Modify.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIColor (JKModify)
- (UIColor *)bp_invertedColor;
- (UIColor *)bp_colorForTranslucency;
- (UIColor *)bp_lightenColor:(CGFloat)lighten;
- (UIColor *)bp_darkenColor:(CGFloat)darken;
@end
