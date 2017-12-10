//
//  CALayer+JKBorderColor.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "CALayer+JKBorderColor.h"

@implementation CALayer (JKBorderColor)

-(void)setBp_borderColor:(UIColor *)_borderColor{
    self.borderColor = _borderColor.CGColor;
}

- (UIColor*)_borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
