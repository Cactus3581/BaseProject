//
//  UIView+BPRoundedCorner.m
//  BaseProject
//
//  Created by Ryan on 2017/12/12.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+BPRoundedCorner.h"
#import <objc/runtime.h>

@implementation NSObject (_BPAdd)

+ (void)bp_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)bp_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)bp_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)bp_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIImage (BPRoundedCorner)

+ (UIImage *)bp_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)bp_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage bp_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

@end


static void *const _BPMaskCornerRadiusLayerKey = "_BPMaskCornerRadiusLayerKey";
static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;

@implementation CALayer (BPRoundedCorner)

+ (void)load {
    [CALayer bp_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(_bp_layoutSublayers)];
}

- (UIImage *)contentImage {
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setContentImage:(UIImage *)contentImage {
    self.contents = (__bridge id)contentImage.CGImage;
}

- (void)bp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    [self bp_roundedCornerWithRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)bp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    [self bp_roundedCornerWithCornerRadii:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

//  设置图片
- (void)bp_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (!color) return;
    CALayer *cornerRadiusLayer = [self bp_getAssociatedValueForKey:_BPMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self bp_setAssociateValue:cornerRadiusLayer withKey:_BPMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer bp_setAssociateValue:color withKey:"_bp_cornerRadiusImageColor"];
    }else{
        [cornerRadiusLayer bp_removeAssociateWithKey:"_bp_cornerRadiusImageColor"];
    }
    [cornerRadiusLayer bp_setAssociateValue:[NSValue valueWithCGSize:cornerRadii] withKey:"_bp_cornerRadiusImageRadius"];
    [cornerRadiusLayer bp_setAssociateValue:@(corners) withKey:"_bp_cornerRadiusImageCorners"];
    if (borderColor) {
        [cornerRadiusLayer bp_setAssociateValue:borderColor withKey:"_bp_cornerRadiusImageBorderColor"];
    }else{
        [cornerRadiusLayer bp_removeAssociateWithKey:"_bp_cornerRadiusImageBorderColor"];
    }
    [cornerRadiusLayer bp_setAssociateValue:@(borderWidth) withKey:"_bp_cornerRadiusImageBorderWidth"];
    UIImage *image = [self _bp_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = image;
        [CATransaction commit];
    }
}

//  获取图片
- (UIImage *)_bp_getCornerRadiusImageFromSet {
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self bp_getAssociatedValueForKey:_BPMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer bp_getAssociatedValueForKey:"_bp_cornerRadiusImageColor"];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer bp_getAssociatedValueForKey:"_bp_cornerRadiusImageRadius"] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer bp_getAssociatedValueForKey:"_bp_cornerRadiusImageCorners"] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer bp_getAssociatedValueForKey:"_bp_cornerRadiusImageBorderWidth"] floatValue];
    UIColor *borderColor = [cornerRadiusLayer bp_getAssociatedValueForKey:"_bp_cornerRadiusImageBorderColor"];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj bp_getAssociatedValueForKey:"_bp_cornerRadiusImageSize"] CGSizeValue];
        UIColor *imageColor = [obj bp_getAssociatedValueForKey:"_bp_cornerRadiusImageColor"];
        CGSize imageRadius = [[obj bp_getAssociatedValueForKey:"_bp_cornerRadiusImageRadius"] CGSizeValue];
        NSUInteger imageCorners = [[obj bp_getAssociatedValueForKey:"_bp_cornerRadiusImageCorners"] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj bp_getAssociatedValueForKey:"_bp_cornerRadiusImageBorderWidth"] floatValue];
        UIColor *imageBorderColor = [obj bp_getAssociatedValueForKey:"_bp_cornerRadiusImageBorderColor"];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage bp_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image bp_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:"_bp_cornerRadiusImageSize"];
        [image bp_setAssociateValue:color withKey:"_bp_cornerRadiusImageColor"];
        [image bp_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:"_bp_cornerRadiusImageRadius"];
        [image bp_setAssociateValue:@(corners) withKey:"_bp_cornerRadiusImageCorners"];
        if (borderColor) {
            [image bp_setAssociateValue:color withKey:"_bp_cornerRadiusImageBorderColor"];
        }
        [image bp_setAssociateValue:@(borderWidth) withKey:"_bp_cornerRadiusImageBorderWidth"];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods
// 规划子Layer的大小和位置
- (void)_bp_layoutSublayers {
    [self _bp_layoutSublayers];
    CALayer *cornerRadiusLayer = [self bp_getAssociatedValueForKey:_BPMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self _bp_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end

@implementation UIView (BPRoundedCorner)

- (void)bp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    [self.layer bp_roundedCornerWithRadius:radius cornerColor:color];
}

- (void)bp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    [self.layer bp_roundedCornerWithRadius:radius cornerColor:color corners:corners];
}

- (void)bp_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    [self.layer bp_roundedCornerWithCornerRadii:cornerRadii cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}

@end
