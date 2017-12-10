//
//  UIImage+Blur.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>
FOUNDATION_EXPORT double ImageEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char ImageEffectsVersionString[];
@interface UIImage (JKBlur)

- (UIImage *)bp_lightImage;
- (UIImage *)bp_extraLightImage;
- (UIImage *)bp_darkImage;
- (UIImage *)bp_tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)bp_blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)bp_blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)bp_blurredImageWithSize:(CGSize)blurSize
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage;
@end
