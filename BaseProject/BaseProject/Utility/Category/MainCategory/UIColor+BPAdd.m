
//
//  UIColor+BPAdd.m
//  WxSelected
//
//  Created by YouLoft_MacMini on 15/12/18.
//  Copyright © 2015年 wazrx. All rights reserved.
//

#import "UIColor+BPAdd.h"

BPSYNTH_DUMMY_CLASS(UIColor_BPAdd)

#define CLAMP_COLOR_VALUE(v) (v) = (v) < 0 ? 0 : (v) > 1 ? 1 : (v)

void BP_RGB2HSL(CGFloat r, CGFloat g, CGFloat b,
                CGFloat *h, CGFloat *s, CGFloat *l) {
    CLAMP_COLOR_VALUE(r);
    CLAMP_COLOR_VALUE(g);
    CLAMP_COLOR_VALUE(b);
    
    CGFloat max, min, delta, sum;
    max = fmaxf(r, fmaxf(g, b));
    min = fminf(r, fminf(g, b));
    delta = max - min;
    sum = max + min;
    
    *l = sum / 2;           // Lightness
    if (delta == 0) {       // No Saturation, so Hue is undefined (achromatic)
        *h = *s = 0;
        return;
    }
    *s = delta / (sum < 1 ? sum : 2 - sum);             // Saturation
    if (r == max) *h = (g - b) / delta / 6;             // color between y & m
    else if (g == max) *h = (2 + (b - r) / delta) / 6;  // color between c & y
    else *h = (4 + (r - g) / delta) / 6;                // color between m & y
    if (*h < 0) *h += 1;
}

void BP_HSL2RGB(CGFloat h, CGFloat s, CGFloat l,
                CGFloat *r, CGFloat *g, CGFloat *b) {
    CLAMP_COLOR_VALUE(h);
    CLAMP_COLOR_VALUE(s);
    CLAMP_COLOR_VALUE(l);
    
    if (s == 0) { // No Saturation, Hue is undefined (achromatic)
        *r = *g = *b = l;
        return;
    }
    
    CGFloat q;
    q = (l <= 0.5) ? (l * (1 + s)) : (l + s - (l * s));
    if (q <= 0) {
        *r = *g = *b = 0.0;
    } else {
        *r = *g = *b = 0;
        int sextant;
        CGFloat m, sv, fract, vsf, mid1, mid2;
        m = l + l - q;
        sv = (q - m) / q;
        if (h == 1) h = 0;
        h *= 6.0;
        sextant = h;
        fract = h - sextant;
        vsf = q * sv * fract;
        mid1 = m + vsf;
        mid2 = q - vsf;
        switch (sextant) {
            case 0: *r = q; *g = mid1; *b = m; break;
            case 1: *r = mid2; *g = q; *b = m; break;
            case 2: *r = m; *g = q; *b = mid1; break;
            case 3: *r = m; *g = mid2; *b = q; break;
            case 4: *r = mid1; *g = m; *b = q; break;
            case 5: *r = q; *g = m; *b = mid2; break;
        }
    }
}

void BP_RGB2HSB(CGFloat r, CGFloat g, CGFloat b,
                CGFloat *h, CGFloat *s, CGFloat *v) {
    CLAMP_COLOR_VALUE(r);
    CLAMP_COLOR_VALUE(g);
    CLAMP_COLOR_VALUE(b);
    
    CGFloat max, min, delta;
    max = fmax(r, fmax(g, b));
    min = fmin(r, fmin(g, b));
    delta = max - min;
    
    *v = max;               // Brightness
    if (delta == 0) {       // No Saturation, so Hue is undefined (achromatic)
        *h = *s = 0;
        return;
    }
    *s = delta / max;       // Saturation
    
    if (r == max) *h = (g - b) / delta / 6;             // color between y & m
    else if (g == max) *h = (2 + (b - r) / delta) / 6;  // color between c & y
    else *h = (4 + (r - g) / delta) / 6;                // color between m & c
    if (*h < 0) *h += 1;
}

void BP_HSB2RGB(CGFloat h, CGFloat s, CGFloat v,
                CGFloat *r, CGFloat *g, CGFloat *b) {
    CLAMP_COLOR_VALUE(h);
    CLAMP_COLOR_VALUE(s);
    CLAMP_COLOR_VALUE(v);
    
    if (s == 0) {
        *r = *g = *b = v; // No Saturation, so Hue is undefined (Achromatic)
    } else {
        int sextant;
        CGFloat f, p, q, t;
        if (h == 1) h = 0;
        h *= 6;
        sextant = floor(h);
        f = h - sextant;
        p = v * (1 - s);
        q = v * (1 - s * f);
        t = v * (1 - s * (1 - f));
        switch (sextant) {
            case 0: *r = v; *g = t; *b = p; break;
            case 1: *r = q; *g = v; *b = p; break;
            case 2: *r = p; *g = v; *b = t; break;
            case 3: *r = p; *g = q; *b = v; break;
            case 4: *r = t; *g = p; *b = v; break;
            case 5: *r = v; *g = p; *b = q; break;
        }
    }
}

void BP_RGB2CMYK(CGFloat r, CGFloat g, CGFloat b,
                 CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k) {
    CLAMP_COLOR_VALUE(r);
    CLAMP_COLOR_VALUE(g);
    CLAMP_COLOR_VALUE(b);
    
    *c = 1 - r;
    *m = 1 - g;
    *y = 1 - b;
    *k = fmin(*c, fmin(*m, *y));
    
    if (*k == 1) {
        *c = *m = *y = 0;   // Pure black
    } else {
        *c = (*c - *k) / (1 - *k);
        *m = (*m - *k) / (1 - *k);
        *y = (*y - *k) / (1 - *k);
    }
}

void BP_CMYK2RGB(CGFloat c, CGFloat m, CGFloat y, CGFloat k,
                 CGFloat *r, CGFloat *g, CGFloat *b) {
    CLAMP_COLOR_VALUE(c);
    CLAMP_COLOR_VALUE(m);
    CLAMP_COLOR_VALUE(y);
    CLAMP_COLOR_VALUE(k);
    
    *r = (1 - c) * (1 - k);
    *g = (1 - m) * (1 - k);
    *b = (1 - y) * (1 - k);
}

void BP_HSB2HSL(CGFloat h, CGFloat s, CGFloat b,
                CGFloat *hh, CGFloat *ss, CGFloat *ll) {
    CLAMP_COLOR_VALUE(h);
    CLAMP_COLOR_VALUE(s);
    CLAMP_COLOR_VALUE(b);
    
    *hh = h;
    *ll = (2 - s) * b / 2;
    if (*ll <= 0.5) {
        *ss = (s) / ((2 - s));
    } else {
        *ss = (s * b) / (2 - (2 - s) * b);
    }
}

void BP_HSL2HSB(CGFloat h, CGFloat s, CGFloat l,
                CGFloat *hh, CGFloat *ss, CGFloat *bb) {
    CLAMP_COLOR_VALUE(h);
    CLAMP_COLOR_VALUE(s);
    CLAMP_COLOR_VALUE(l);
    
    *hh = h;
    if (l <= 0.5) {
        *bb = (s + 1) * l;
        *ss = (2 * s) / (s + 1);
    } else {
        *bb = l + s * (1 - l);
        *ss = (2 * s * (1 - l)) / *bb;
    }
}


@implementation UIColor (BPAdd)

- (CGFloat)red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (CGFloat)hue {
    CGFloat h = 0, s, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return h;
}

- (CGFloat)saturation {
    CGFloat h, s = 0, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return s;
}

- (CGFloat)brightness {
    CGFloat h, s, b = 0, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return b;
}

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *)colorSpaceString {
    CGColorSpaceModel model =  CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    switch (model) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
            
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
            
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
            
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
            
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
            
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
            
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
            
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
            
        default:
            return @"ColorSpaceInvalid";
    }
}

- (uint32_t)rgbValue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int8_t red = r * 255;
    uint8_t green = g * 255;
    uint8_t blue = b * 255;
    return (red << 16) + (green << 8) + blue;
}

- (uint32_t)rgbaValue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int8_t red = r * 255;
    uint8_t green = g * 255;
    uint8_t blue = b * 255;
    uint8_t alpha = a * 255;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}


- (NSString *)hexString {
    return [self _bp_hexStringWithAlpha:NO];
}

- (NSString *)hexStringWithAlpha {
    return [self _bp_hexStringWithAlpha:YES];
}

+ (UIColor *)bp_colorWithHue:(CGFloat)hue
               saturation:(CGFloat)saturation
                lightness:(CGFloat)lightness
                    alpha:(CGFloat)alpha {
    CGFloat r, g, b;
    BP_HSL2RGB(hue, saturation, lightness, &r, &g, &b);
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
	
}

+ (UIColor *)bp_colorWithCyan:(CGFloat)cyan
                   magenta:(CGFloat)magenta
                    yellow:(CGFloat)yellow
                     black:(CGFloat)black
                     alpha:(CGFloat)alpha {
    CGFloat r, g, b;
    BP_CMYK2RGB(cyan, magenta, yellow, black, &r, &g, &b);
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
	
}

+ (UIColor *)bp_colorWithRGB:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

+ (UIColor *)bp_colorWithRGBA:(uint32_t)rgbaValue {
    return [UIColor colorWithRed:((rgbaValue & 0xFF000000) >> 24) / 255.0f
                           green:((rgbaValue & 0xFF0000) >> 16) / 255.0f
                            blue:((rgbaValue & 0xFF00) >> 8) / 255.0f
                           alpha:(rgbaValue & 0xFF) / 255.0f];
	
}

+ (UIColor *)bp_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:alpha];
	
}

+ (UIColor *)bp_colorWithHexString:(NSString *)hexStr {
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (UIColor *)bp_colorByAddColor:(UIColor *)add blendMode:(CGBlendMode)blendMode {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    uint8_t pixel[4] = { 0 };
    CGContextRef context = CGBitmapContextCreate(&pixel, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextSetBlendMode(context, blendMode);
    CGContextSetFillColorWithColor(context, add.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIColor colorWithRed:pixel[0] / 255.0f green:pixel[1] / 255.0f blue:pixel[2] / 255.0f alpha:pixel[3] / 255.0f];
}

- (UIColor *)bp_colorByChangeHue:(CGFloat)hueDelta
                   saturation:(CGFloat)saturationDelta
                   brightness:(CGFloat)brightnessDelta
                        alpha:(CGFloat)alphaDelta {
    CGFloat hh, ss, bb, aa;
    if (![self getHue:&hh saturation:&ss brightness:&bb alpha:&aa]) {
        return nil;
    }
    hh += hueDelta;
    ss += saturationDelta;
    bb += brightnessDelta;
    aa += alphaDelta;
    hh -= (int)hh;
    hh = hh < 0 ? hh + 1 : hh;
    ss = ss < 0 ? 0 : ss > 1 ? 1 : ss;
    bb = bb < 0 ? 0 : bb > 1 ? 1 : bb;
    aa = aa < 0 ? 0 : aa > 1 ? 1 : aa;
    return [UIColor colorWithHue:hh saturation:ss brightness:bb alpha:aa];
}

+ (UIColor *)bp_colorWithInterpolationFromValue:(UIColor *)from toValue:(UIColor *)to ratio:(CGFloat)ratio{
    CGFloat red = [self _bp_interpolationFromValue:from.red toValue:to.red ratio:ratio];
    CGFloat green = [self _bp_interpolationFromValue:from.green toValue:to.green ratio:ratio];
    CGFloat blue = [self _bp_interpolationFromValue:from.blue toValue:to.blue ratio:ratio];
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
}

#pragma mark - private methods

- (NSString *)_bp_hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(self.alpha * 255.0 + 0.5)];
    }
    return hex;
}

+ (CGFloat)_bp_interpolationFromValue:(CGFloat)from toValue:(CGFloat)to ratio:(CGFloat)ratio{
    return from + (to - from) * ratio;
}

+ (UIColor *)bp_randomColor {
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
	
}

+ (UIColor *)bp_randomColorInColorArray:(NSArray *)colorArray {
    if (!colorArray.count)return [UIColor whiteColor];
    return colorArray[arc4random() % colorArray.count];
}

#pragma mark - Chameleon - Light Shades

+ (UIColor *)xBlackColor {
    return hsb(0, 0, 17);
}

+ (UIColor *)xBlueColor {
    return hsb(224, 50, 63);
}

+ (UIColor *)xBrownColor {
    return hsb(24, 45, 37);
}

+ (UIColor *)xCoffeeColor {
    return hsb(25, 31, 64);
}

+ (UIColor *)xForestGreenColor {
    return hsb(138, 45, 37);
}

+ (UIColor *)xGrayColor {
    return hsb(184, 10, 65);
}

+ (UIColor *)xGreenColor {
    return hsb(145, 77, 80);
}

+ (UIColor *)xLimeColor {
    return hsb(74, 70, 78);
}

+ (UIColor *)xMagentaColor {
    return hsb(283, 51, 71);
}

+ (UIColor *)xMaroonColor {
    return hsb(5, 65, 47);
}

+ (UIColor *)xMintColor {
    return hsb(168, 86, 74);
}

+ (UIColor *)xNavyBlueColor {
    return hsb(210, 45, 37);
}

+ (UIColor *)xOrangeColor {
    return hsb(28, 85, 90);
}

+ (UIColor *)xPinkColor {
    return hsb(324, 49, 96);
}

+ (UIColor *)xPlumColor {
    return hsb(300, 45, 37);
}

+ (UIColor *)xPowderBlueColor {
    return hsb(222, 24, 95);
}

+ (UIColor *)xPurpleColor {
    return hsb(253, 52, 77);
}

+ (UIColor *)xRedColor {
    return hsb(6, 74, 91);
}

+ (UIColor *)xSandColor {
    return hsb(42, 25, 94);
}

+ (UIColor *)xSkyBlueColor {
    return hsb(204, 76, 86);
}

+ (UIColor *)xTealColor {
    return hsb(195, 55, 51);
}

+ (UIColor *)xWatermelonColor {
    return hsb(356, 53, 94);
}

+ (UIColor *)xWhiteColor {
    return hsb(192, 2, 95);
}

+ (UIColor *)xYellowColor {
    return hsb(48, 99, 100);
}

#pragma mark - Chameleon - Dark Shades

+ (UIColor *)xBlackColorDark {
    return hsb(0, 0, 15);
}

+ (UIColor *)xBlueColorDark {
    return hsb(224, 56, 51);
}

+ (UIColor *)xBrownColorDark {
    return hsb(25, 45, 31);
}

+ (UIColor *)xCoffeeColorDark {
    return hsb(25, 34, 56);
}

+ (UIColor *)xForestGreenColorDark {
    return hsb(135, 44, 31);
}

+ (UIColor *)xGrayColorDark {
    return hsb(184, 10, 55);
}

+ (UIColor *)xGreenColorDark {
    return hsb(145, 78, 68);
}

+ (UIColor *)xLimeColorDark {
    return hsb(74, 81, 69);
}

+ (UIColor *)xMagentaColorDark {
    return hsb(282, 61, 68);
}

+ (UIColor *)xMaroonColorDark {
    return hsb(4, 68, 40);
}

+ (UIColor *)xMintColorDark {
    return hsb(168, 86, 63);
}

+ (UIColor *)xNavyBlueColorDark {
    return hsb(210, 45, 31);
}

+ (UIColor *)xOrangeColorDark {
    return hsb(24, 100, 83);
}

+ (UIColor *)xPinkColorDark {
    return hsb(327, 57, 83);
}

+ (UIColor *)xPlumColorDark {
    return hsb(300, 46, 31);
}

+ (UIColor *)xPowderBlueColorDark {
    return hsb(222, 28, 84);
}

+ (UIColor *)xPurpleColorDark {
    return hsb(253, 56, 64);
}

+ (UIColor *)xRedColorDark {
    return hsb(6, 78, 75);
}

+ (UIColor *)xSandColorDark {
    return hsb(42, 30, 84);
}

+ (UIColor *)xSkyBlueColorDark {
    return hsb(204, 78, 73);
}

+ (UIColor *)xTealColorDark {
    return hsb(196, 54, 45);
}

+ (UIColor *)xWatermelonColorDark {
    return hsb(358, 61, 85);
}

+ (UIColor *)xWhiteColorDark {
    return hsb(204, 5, 78);
}

+ (UIColor *)xYellowColorDark {
    return hsb(40, 100, 100);
}

+ (UIColor *)bp_colorWithGradientStyle:(BPGradientStyle)gradientStyle withFrame:(CGRect)frame andColors:(NSArray *)colors {
    CAGradientLayer *backgroundGradientLayer = [CAGradientLayer layer];
    backgroundGradientLayer.frame = frame;
    NSMutableArray *cgColors = [[NSMutableArray alloc] init];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    switch (gradientStyle) {
        case BPGradientStyleLeftToRight: {
            backgroundGradientLayer.colors = cgColors;
            [backgroundGradientLayer setStartPoint:CGPointMake(0.0, 0.5)];
            [backgroundGradientLayer setEndPoint:CGPointMake(1.0, 0.5)];
            UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
            [backgroundGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return [UIColor colorWithPatternImage:backgroundColorImage];
        }
            
        case BPGradientStyleRadial: {
            UIGraphicsBeginImageContextWithOptions(frame.size,NO, [UIScreen mainScreen].scale);
            CGFloat locations[2] = {0.0, 1.0};
            CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
            CFArrayRef arrayRef = (__bridge CFArrayRef)cgColors;
            CGGradientRef myGradient = CGGradientCreateWithColors(myColorspace, arrayRef, locations);
            CGPoint myCentrePoint = CGPointMake(0.5 * frame.size.width, 0.5 * frame.size.height);
            float myRadius = MIN(frame.size.width, frame.size.height) * 1.0;
            CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,
                                         0, myCentrePoint, myRadius,
                                         kCGGradientDrawsAfterEndLocation);
            UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            CGColorSpaceRelease(myColorspace);
            CGGradientRelease(myGradient);
            UIGraphicsEndImageContext();
            return [UIColor colorWithPatternImage:backgroundColorImage];
        }
            
        case BPGradientStyleTopToBottom:
        default: {
            backgroundGradientLayer.colors = cgColors;
            UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
            [backgroundGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return [UIColor colorWithPatternImage:backgroundColorImage];
        }
    }
}


@end
