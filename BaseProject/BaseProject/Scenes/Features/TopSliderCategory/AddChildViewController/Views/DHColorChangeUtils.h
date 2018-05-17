//
//  DHColorChangeUtils.h
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/14.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DHColorChangeUtils : NSObject
/**
 * 颜色渐变
 */
+ (UIColor *)getColorOfPercent:(CGFloat)percent betweenColor:(UIColor *)oldColor andColor:(UIColor *)newColor;

@end
