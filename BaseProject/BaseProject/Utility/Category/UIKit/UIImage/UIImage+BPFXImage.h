//
//  UIImage+FX.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (BPFXImage)

- (UIImage *)bp_imageCroppedToRect:(CGRect)rect;
- (UIImage *)bp_imageScaledToSize:(CGSize)size;
- (UIImage *)bp_imageScaledToFitSize:(CGSize)size;
- (UIImage *)bp_imageScaledToFillSize:(CGSize)size;
- (UIImage *)bp_imageCroppedAndScaledToSize:(CGSize)size
                             contentMode:(UIViewContentMode)contentMode
                                padToFit:(BOOL)padToFit;

- (UIImage *)bp_reflectedImageWithScale:(CGFloat)scale;
- (UIImage *)bp_imageWithReflectionWithScale:(CGFloat)scale gap:(CGFloat)gap alpha:(CGFloat)alpha;
- (UIImage *)bp_imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
- (UIImage *)bp_imageWithCornerRadius:(CGFloat)radius;
- (UIImage *)bp_imageWithAlpha:(CGFloat)alpha;
- (UIImage *)bp_imageWithMask:(UIImage *)maskImage;

- (UIImage *)bp_maskImageFromImageAlpha;


@end
