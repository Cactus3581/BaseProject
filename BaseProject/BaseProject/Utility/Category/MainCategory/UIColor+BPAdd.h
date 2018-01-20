//
//  UIColor+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 15/12/18.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, BPGradientStyle) {
    BPGradientStyleLeftToRight,//左->右渐变
    BPGradientStyleRadial,//中间扩散
    BPGradientStyleTopToBottom//上->下渐变
};

#ifndef hsb
#define hsb(_h_, _s_, _b_) [UIColor colorWithHue:(_h_) / 360.0f saturation:(_s_) / 100.0f brightness:(_b_)/100.0f alpha:1.0]
#endif

#ifndef hsba
#define hsba(_h_, _s_, _b_, _a_) [UIColor colorWithHue:(_h_) / 360.0f saturation:(_s_) / 100.0f brightness:(_b_)/100.0f alpha:_a_]
#endif

#ifndef HexColor
#define HexColor(_hex_)   [UIColor bp_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

@interface UIColor (BPAdd)

#pragma mark - fast property (快速获取颜色信息)

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat hue;
/**饱和度*/
@property (nonatomic, readonly) CGFloat saturation;
@property (nonatomic, readonly) CGFloat brightness;
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nullable, nonatomic, readonly) NSString *colorSpaceString;
@property (nonatomic, readonly) uint32_t rgbValue;
@property (nonatomic, readonly) uint32_t rgbaValue;
@property (nullable, nonatomic, readonly) NSString *hexString;
@property (nullable, nonatomic, readonly) NSString *hexStringWithAlpha;

#pragma mark - color initailize (颜色初始化相关)

/**Color With HSL*/
+ (UIColor *)bp_colorWithHue:(CGFloat)hue
               saturation:(CGFloat)saturation
                lightness:(CGFloat)lightness
                    alpha:(CGFloat)alpha;


/**Color With CMYB*/
+ (UIColor *)bp_colorWithCyan:(CGFloat)cyan
                   magenta:(CGFloat)magenta
                    yellow:(CGFloat)yellow
                     black:(CGFloat)black
                     alpha:(CGFloat)alpha;

/**Color with hex value*/
+ (UIColor *)bp_colorWithRGB:(uint32_t)rgbValue;
+ (UIColor *)bp_colorWithRGBA:(uint32_t)rgbaValue;
+ (UIColor *)bp_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/**Color with hex string*/
+ (nullable UIColor *)bp_colorWithHexString:(NSString *)hexStr;

#pragma mark - color change (颜色改变相关)

/**
 *  混合颜色
 *
 *  @param add       需要混合的颜色
 *  @param blendMode 混合方式
 *
 *  @return 混合后的颜色
 */
- (UIColor *)bp_colorByAddColor:(UIColor *)add blendMode:(CGBlendMode)blendMode;

/**改变颜色的HSB*/
- (UIColor *)bp_colorByChangeHue:(CGFloat)hueDelta
                   saturation:(CGFloat)saturationDelta
                   brightness:(CGFloat)brightnessDelta
                        alpha:(CGFloat)alphaDelta;

#pragma mark - interpolation (插值相关)
/**
 *  插值两种颜色返回中间的颜色
 *
 *  @param from  起始颜色
 *  @param to    终止颜色
 *  @param ratio 插值比例
 *
 *  @return 插值色
 */
+ (UIColor *)bp_colorWithInterpolationFromValue:(UIColor *)from toValue:(UIColor *)to ratio:(CGFloat)ratio;

#pragma mark - randomColor (随机色)

+ (UIColor *)bp_randomColor;

+ (UIColor *)bp_randomColorInColorArray:(NSArray *)colorArray;

#pragma mark - more color (更多颜色)

#pragma mark - Light Shades

+ (UIColor *)xBlackColor;

+ (UIColor *)xBlueColor;

+ (UIColor *)xBrownColor;

+ (UIColor *)xCoffeeColor;

+ (UIColor *)xForestGreenColor;

+ (UIColor *)xGrayColor;

+ (UIColor *)xGreenColor;

+ (UIColor *)xLimeColor;

+ (UIColor *)xMagentaColor;

+ (UIColor *)xMaroonColor;

+ (UIColor *)xMintColor;

+ (UIColor *)xNavyBlueColor;

+ (UIColor *)xOrangeColor;

+ (UIColor *)xPinkColor;

+ (UIColor *)xPlumColor;

+ (UIColor *)xPowderBlueColor;

+ (UIColor *)xPurpleColor;

+ (UIColor *)xRedColor;

+ (UIColor *)xSandColor;

+ (UIColor *)xSkyBlueColor;

+ (UIColor *)xTealColor;

+ (UIColor *)xWatermelonColor;

+ (UIColor *)xWhiteColor;

+ (UIColor *)xYellowColor;

+ (UIColor *)xBlackColorDark;

+ (UIColor *)xBlueColorDark;

+ (UIColor *)xBrownColorDark;

+ (UIColor *)xCoffeeColorDark;

+ (UIColor *)xForestGreenColorDark;

+ (UIColor *)xGrayColorDark;

+ (UIColor *)xGreenColorDark;

+ (UIColor *)xLimeColorDark;

+ (UIColor *)xMagentaColorDark;

+ (UIColor *)xMaroonColorDark;

+ (UIColor *)xMintColorDark;

+ (UIColor *)xNavyBlueColorDark;

+ (UIColor *)xOrangeColorDark;

+ (UIColor *)xPinkColorDark;

+ (UIColor *)xPlumColorDark;

+ (UIColor *)xPowderBlueColorDark;

+ (UIColor *)xPurpleColorDark;

+ (UIColor *)xRedColorDark;

+ (UIColor *)xSandColorDark;

+ (UIColor *)xSkyBlueColorDark;

+ (UIColor *)xTealColorDark;

+ (UIColor *)xWatermelonColorDark;

+ (UIColor *)xWhiteColorDark;

+ (UIColor *)xYellowColorDark;

#pragma mark - Gradient Color (渐变色相关)

+ (UIColor *)bp_colorWithGradientStyle:(BPGradientStyle)gradientStyle withFrame:(CGRect)frame andColors:(NSArray *)colors;

#pragma mark - Color Macro (颜色宏)


#ifndef XBlackC
#define XBlackC [UIColor xBlackColor]
#endif

#ifndef XBlueC
#define XBlueC [UIColor xBlueColor]
#endif

#ifndef XBrownC
#define XBrownC [UIColor xBrownColor]
#endif

#ifndef XCoffeeC
#define XCoffeeC [UIColor xCoffeeColor]
#endif

#ifndef XForestGreenC
#define XForestGreenC [UIColor xForestGreenColor]
#endif

#ifndef XGrayC
#define XGrayC [UIColor xGrayColor]
#endif

#ifndef XGreenC
#define XGreenC [UIColor xGreenColor]
#endif

#ifndef XLimeC
#define XLimeC [UIColor xLimeColor]
#endif

#ifndef XMagentaC
#define XMagentaC [UIColor xMagentaColor]
#endif

#ifndef XMaroonC
#define XMaroonC [UIColor xMaroonColor]
#endif

#ifndef XMintC
#define XMintC [UIColor xMintColor]
#endif

#ifndef XNavyBlueC
#define XNavyBlueC [UIColor xNavyBlueColor]
#endif

#ifndef XOrangeC
#define XOrangeC [UIColor xOrangeColor]
#endif

#ifndef XPinkC
#define XPinkC [UIColor xPinkColor]
#endif

#ifndef XPlumC
#define XPlumC [UIColor xPlumColor]
#endif

#ifndef XPowderBlueC
#define XPowderBlueC [UIColor xPowderBlueColor]
#endif

#ifndef XPurpleC
#define XPurpleC [UIColor xPurpleColor]
#endif

#ifndef XRedC
#define XRedC [UIColor xRedColor]
#endif

#ifndef XSandC
#define XSandC [UIColor xSandColor]
#endif

#ifndef XSkyBlueC
#define XSkyBlueC [UIColor xSkyBlueColor]
#endif

#ifndef XTealC
#define XTealC [UIColor xTealColor]
#endif

#ifndef BPatermelonC
#define BPatermelonC [UIColor xWatermelonColor]
#endif

#ifndef BPhiteC
#define BPhiteC [UIColor xWhiteColor]
#endif

#ifndef XYellowC
#define XYellowC [UIColor xYellowColor]
#endif

#ifndef XBlackDarkC
#define XBlackDarkC [UIColor xBlackColorDark]
#endif

#ifndef XBlueDarkC
#define XBlueDarkC [UIColor xBlueColorDark]
#endif

#ifndef XBrownDarkC
#define XBrownDarkC [UIColor xBrownColorDark]
#endif

#ifndef XCoffeeDarkC
#define XCoffeeDarkC [UIColor xCoffeeColorDark]
#endif

#ifndef XForestGreenDarkC
#define XForestGreenDarkC [UIColor xForestGreenColorDark]
#endif

#ifndef XGrayDarkC
#define XGrayDarkC [UIColor xGrayColorDark]
#endif

#ifndef XGreenDarkC
#define XGreenDarkC [UIColor xGreenColorDark]
#endif

#ifndef XLimeDarkC
#define XLimeDarkC [UIColor xLimeColorDark]
#endif

#ifndef XMagentaDarkC
#define XMagentaDarkC [UIColor xMagentaColorDark]
#endif

#ifndef XMaroonDarkC
#define XMaroonDarkC [UIColor xMaroonColorDark]
#endif

#ifndef XMintDarkC
#define XMintDarkC [UIColor xMintColorDark]
#endif

#ifndef XNavyBlueDarkC
#define XNavyBlueDarkC [UIColor xNavyBlueColorDark]
#endif

#ifndef XOrangeDarkC
#define XOrangeDarkC [UIColor xOrangeColorDark]
#endif

#ifndef XPinkDarkC
#define XPinkDarkC [UIColor xPinkColorDark]
#endif

#ifndef XPlumDarkC
#define XPlumDarkC [UIColor xPlumColorDark]
#endif

#ifndef XPowderBlueDarkC
#define XPowderBlueDarkC [UIColor xPowderBlueColorDark]
#endif

#ifndef XPurpleDarkC
#define XPurpleDarkC [UIColor xPurpleColorDark]
#endif

#ifndef XRedDarkC
#define XRedDarkC [UIColor xRedColorDark]
#endif

#ifndef XSandDarkC
#define XSandDarkC [UIColor xSandColorDark]
#endif

#ifndef XSkyBlueDarkC
#define XSkyBlueDarkC [UIColor xSkyBlueColorDark]
#endif

#ifndef XTealDarkC
#define XTealDarkC [UIColor xTealColorDark]
#endif

#ifndef BPatermelonDarkC
#define BPatermelonDarkC [UIColor xWatermelonColorDark]
#endif

#ifndef BPhiteDarkC
#define BPhiteDarkC [UIColor xWhiteColorDark]
#endif

#ifndef XYellowDarkC
#define XYellowDarkC [UIColor xYellowColorDark]
#endif

#ifndef BlackC
#define BlackC [UIColor blackColor]
#endif

#ifndef DarkGrayC
#define DarkGrayC [UIColor darkGrayColor]
#endif

#ifndef LightGrayC
#define LightGrayC [UIColor lightGrayColor]
#endif

#ifndef WhiteC
#define WhiteC [UIColor whiteColor]
#endif

#ifndef GrayC
#define GrayC [UIColor grayColor]
#endif

#ifndef RedC
#define RedC [UIColor redColor]
#endif

#ifndef GreenC
#define GreenC [UIColor greenColor]
#endif

#ifndef BlueC
#define BlueC [UIColor blueColor]
#endif

#ifndef CyanC
#define CyanC [UIColor cyanColor]
#endif

#ifndef YellowC
#define YellowC [UIColor yellowColor]
#endif

#ifndef MagentaC
#define MagentaC [UIColor magentaColor]
#endif

#ifndef OrangeC
#define OrangeC [UIColor orangeColor]
#endif

#ifndef PurpleC
#define PurpleC [UIColor purpleColor]
#endif

#ifndef BrownC
#define BrownC [UIColor brownColor]
#endif

#ifndef ClearC
#define ClearC [UIColor clearColor]
#endif

@end

NS_ASSUME_NONNULL_END
