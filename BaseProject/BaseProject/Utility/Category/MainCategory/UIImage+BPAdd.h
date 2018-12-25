//
//  UIImage+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 15/12/29.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BPAdd)

@property (nonatomic, readonly) BOOL hasAlphaChannel;

#pragma mark - image initialize (图片初始化相关)

+ (UIImage *)bp_imageWithPDF:(id)dataOrPath;

+ (UIImage *)bp_imageWithPDF:(id)dataOrPath size:(CGSize)size;

+ (UIImage *)bp_imageWithEmoji:(NSString *)emoji size:(CGFloat)size;

/**尺寸默认1*1*/
+ (UIImage *)bp_imageWithColor:(UIColor *)color;

+ (UIImage *)bp_imageWithColor:(UIColor *)color size:(CGSize)size;

/**通过绘制block，绘制一张图片*/
+ (UIImage *)bp_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

#pragma mark - modify image (图片修改相关, 裁剪，缩放，旋转)

- (nullable UIImage *)bp_imageByResizeToSize:(CGSize)size;

- (nullable UIImage *)bp_imageByCropToRect:(CGRect)rect;

- (nullable UIImage *)bp_imageByInsetEdge:(UIEdgeInsets)insets withColor:(nullable UIColor *)color;

- (nullable UIImage *)bp_imageByRoundCornerRadius:(CGFloat)radius;

- (nullable UIImage *)bp_imageByRoundCornerRadius:(CGFloat)radius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor;

- (nullable UIImage *)bp_imageByRoundCornerRadius:(CGFloat)radius
                                       corners:(UIRectCorner)corners
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor
                                borderLineJoin:(CGLineJoin)borderLineJoin;

- (nullable UIImage *)bp_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

- (nullable UIImage *)bp_imageByRotateLeft90;

- (nullable UIImage *)bp_imageByRotateRight90;

- (nullable UIImage *)bp_imageByRotate180;

- (nullable UIImage *)bp_imageByFlipVertical;

- (nullable UIImage *)bp_imageByFlipHorizontal;

#pragma mark - effect image(给图片添加效果相关，如颜色、模糊等)

- (nullable UIImage *)bp_imageByTintColor:(UIColor *)color;

- (nullable UIImage *)bp_imageByGrayscale;

- (nullable UIImage *)bp_imageByBlurSoft;

- (nullable UIImage *)bp_imageByBlurLight;

- (nullable UIImage *)bp_imageByBlurExtraLight;

- (nullable UIImage *)bp_imageByBlurDark;

- (nullable UIImage *)bp_imageByBlurWithTint:(UIColor *)tintColor;

- (nullable UIImage *)bp_imageByBlurRadius:(CGFloat)blurRadius
                              tintColor:(nullable UIColor *)tintColor
                               tintMode:(CGBlendMode)tintBlendMode
                             saturation:(CGFloat)saturation
                              maskImage:(nullable UIImage *)maskImage;
@end

NS_ASSUME_NONNULL_END
