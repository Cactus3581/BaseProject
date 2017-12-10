//
//  UIColor+HEX.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JKHEX)
+ (UIColor *)bp_colorWithHex:(UInt32)hex;
+ (UIColor *)bp_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)bp_colorWithHexString:(NSString *)hexString;
- (NSString *)bp_HEXString;
///值不需要除以255.0
+ (UIColor *)bp_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;
///值不需要除以255.0
+ (UIColor *)bp_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;
@end
