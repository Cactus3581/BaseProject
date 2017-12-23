//
//  UIColor+Web.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIColor+BPWeb.h"

@implementation UIColor (BPWeb)
/**
 *  @brief  获取canvas用的颜色字符串
 *
 *  @return canvas颜色
 */
- (NSString *)bp_canvasColorString
{
    CGFloat *arrRGBA = [self bp_getRGB];
    int r = arrRGBA[0] * 255;
    int g = arrRGBA[1] * 255;
    int b = arrRGBA[2] * 255;
    float a = arrRGBA[3];
    return [NSString stringWithFormat:@"rgba(%d,%d,%d,%f)", r, g, b, a];
}
/**
 *  @brief  获取网页颜色字串
 *
 *  @return 网页颜色
 */
- (NSString *)bp_webColorString
{
    CGFloat *arrRGBA = [self bp_getRGB];
    int r = arrRGBA[0] * 255;
    int g = arrRGBA[1] * 255;
    int b = arrRGBA[2] * 255;
    NSLog(@"%d,%d,%d", r, g, b);
    NSString *webColor = [NSString stringWithFormat:@"#%02X%02X%02X", r, g, b];
    return webColor;
}

- (CGFloat *) bp_getRGB{
    UIColor * uiColor = self;
    CGColorRef cgColor = [uiColor CGColor];
    int numComponents = (int)CGColorGetNumberOfComponents(cgColor);
    if (numComponents == 4){
        static CGFloat * components = Nil;
        components = (CGFloat *) CGColorGetComponents(cgColor);
        return (CGFloat *)components;
    } else { //否则默认返回黑色
        static CGFloat components[4] = {0};
        CGFloat f = 0;
        //非RGB空间的系统颜色单独处理
        if ([uiColor isEqual:[UIColor whiteColor]]) {
            f = 1.0;
        } else if ([uiColor isEqual:[UIColor lightGrayColor]]) {
            f = 0.8;
        } else if ([uiColor isEqual:[UIColor grayColor]]) {
            f = 0.5;
        }
        components[0] = f;
        components[1] = f;
        components[2] = f;
        components[3] = 1.0;
        return (CGFloat *)components;
    }
}
@end
