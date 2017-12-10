//
//  CALayer+JKBorderColor.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "CALayer+JKBorderColor.h"

@implementation CALayer (JKBorderColor)

-(void)setJk_borderColor:(UIColor *)jk_borderColor{
    self.borderColor = jk_borderColor.CGColor;
}

- (UIColor*)jk_borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
