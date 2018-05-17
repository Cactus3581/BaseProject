//
//  DHColorChangeUtils.m
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/14.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import "DHColorChangeUtils.h"

@implementation DHColorChangeUtils

+ (UIColor *)getColorOfPercent:(CGFloat)percent betweenColor:(UIColor *)oldColor andColor:(UIColor *)newColor
{
    CGFloat red1, green1, blue1, alpha1;
    CGFloat red2, green2, blue2, alpha2;
    [oldColor getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    [newColor getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    CGFloat p1 = percent;
    CGFloat p2 = 1.0 - percent;
    UIColor *midColor = [UIColor colorWithRed:red1 * p1 + red2 * p2 green:green1 * p1 + green2 * p2 blue:blue1 *p1 + blue2 * p2 alpha:1.0f];
    return midColor;
}

@end
