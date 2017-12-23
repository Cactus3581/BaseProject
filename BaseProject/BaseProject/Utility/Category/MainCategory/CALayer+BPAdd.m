//
//  CALayer+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 16/1/28.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "CALayer+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(CALayer_BPAdd)

@implementation CALayer (BPAdd)

- (UIImage *)bp_snapshotImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSData *)bp_snapshotPDF{
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)bp_shadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius{
    self.shadowColor = color.CGColor;
    self.shadowOffset = offset;
    self.shadowRadius = radius;
    self.shadowOpacity = 1;
    self.shouldRasterize = YES;
    self.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)bp_removeAllSublayers{
    [self.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (void)bp_shakeInBPithDistace:(CGFloat)distance repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration{
    [self removeAnimationForKey:@"bp_shakeInBPithDistace"];
    CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
    anim.keyPath=@"transform.translation.x";
    anim.values=@[@(0), @(distance),@(0),@(-distance), @(0)];
    anim.repeatCount = count;
    anim.duration = duration;
    [self addAnimation:anim forKey:@"bp_shakeInBPithDistace"];
}

- (void)bp_shakeInYWithDistace:(CGFloat)distance repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration{
    [self removeAnimationForKey:@"bp_shakeInYWithDistace"];
    CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
    anim.keyPath=@"transform.translation.y";
    anim.values=@[@(0), @(distance),@(0),@(-distance), @(0)];
    anim.repeatCount = count;
    anim.duration = duration;
    [self addAnimation:anim forKey:@"bp_shakeInYWithDistace"];
}

- (void)bp_rotationInZWithAngle:(CGFloat)angle repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration{
    [self removeAnimationForKey:@"bp_rotationInZWithAngle"];
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.fromValue = @(0);
    anim.toValue = @(angle);
    anim.duration = duration;
    anim.repeatCount = count;
    [self addAnimation:anim forKey:@"bp_rotationInZWithAngle"];
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)center{
    return CGPointMake(self.frame.origin.x + self.frame.size.width * 0.5,
                       self.frame.origin.y + self.frame.size.height * 0.5);
}

- (void)setCenter:(CGPoint)center{
    CGRect frame = self.frame;
    frame.origin.x = center.x - frame.size.width * 0.5;
    frame.origin.y = center.y - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGFloat)centerX{
    return self.frame.origin.x + self.frame.size.width * 0.5;
}

- (void)setCenterX:(CGFloat)centerX{
    CGRect frame = self.frame;
    frame.origin.x = centerX - frame.size.width * 0.5;
    self.frame = frame;
}

- (CGFloat)centerY{
    return self.frame.origin.y + self.frame.size.height * 0.5;
}

- (void)setCenterY:(CGFloat)centerY{
    CGRect frame = self.frame;
    frame.origin.y = centerY - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)transformRotation{
    NSNumber *v = [self valueForKeyPath:@"transform.rotation"];
    return v.doubleValue;
}

- (void)setTransformRotation:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.rotation"];
}

- (CGFloat)transformRotationX{
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.x"];
    return v.doubleValue;
}

- (void)setTransformRotationX:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.rotation.x"];
}

- (CGFloat)transformRotationY{
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.y"];
    return v.doubleValue;
}

- (void)setTransformRotationY:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.rotation.y"];
}

- (CGFloat)transformRotationZ{
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.z"];
    return v.doubleValue;
}

- (void)setTransformRotationZ:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.rotation.z"];
}

- (CGFloat)transformScaleX{
    NSNumber *v = [self valueForKeyPath:@"transform.scale.x"];
    return v.doubleValue;
}

- (void)setTransformScaleX:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.scale.x"];
}

- (CGFloat)transformScaleY{
    NSNumber *v = [self valueForKeyPath:@"transform.scale.y"];
    return v.doubleValue;
}

- (void)setTransformScaleY:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.scale.y"];
}

- (CGFloat)transformScaleZ{
    NSNumber *v = [self valueForKeyPath:@"transform.scale.z"];
    return v.doubleValue;
}

- (void)setTransformScaleZ:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.scale.z"];
}

- (CGFloat)transformScale{
    NSNumber *v = [self valueForKeyPath:@"transform.scale"];
    return v.doubleValue;
}

- (void)setTransformScale:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.scale"];
}

- (CGFloat)transformTranslationX{
    NSNumber *v = [self valueForKeyPath:@"transform.translation.x"];
    return v.doubleValue;
}

- (void)setTransformTranslationX:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.translation.x"];
}

- (CGFloat)transformTranslationY{
    NSNumber *v = [self valueForKeyPath:@"transform.translation.y"];
    return v.doubleValue;
}

- (void)setTransformTranslationY:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.translation.y"];
}

- (CGFloat)transformTranslationZ{
    NSNumber *v = [self valueForKeyPath:@"transform.translation.z"];
    return v.doubleValue;
}

- (void)setTransformTranslationZ:(CGFloat)v{
    [self setValue:@(v) forKeyPath:@"transform.translation.z"];
}

- (CGFloat)m34 {
    return self.transform.m34;
}

- (void)setM34:(CGFloat)v {
    CATransform3D d = self.transform;
    d.m34 = v;
    self.transform = d;
}

- (void)bp_anchorPointChangedToPoint:(CGPoint)point {
    self.x += (point.x - self.anchorPoint.x) * self.width;
    self.y += (point.y - self.anchorPoint.y) * self.height;
    self.anchorPoint = point;
}

- (void)bp_anchorPointChangedTotopLeft {
    [self bp_anchorPointChangedToPoint:CGPointMake(0, 0)];
}

- (void)bp_anchorPointChangedTotopCenter {
    [self bp_anchorPointChangedToPoint:CGPointMake(0.5, 0)];
}

- (void)bp_anchorPointChangedToTopRight {
    [self bp_anchorPointChangedToPoint:CGPointMake(1, 0)];
}

- (void)bp_anchorPointChangedToMidLeft {
    [self bp_anchorPointChangedToPoint:CGPointMake(0, 0.5)];
}

- (void)bp_anchorPointChangedToMidCenter {
    [self bp_anchorPointChangedToPoint:CGPointMake(0.5, 0.5)];
}

- (void)bp_anchorPointChangedToMidRight {
    [self bp_anchorPointChangedToPoint:CGPointMake(1, 0.5)];
}

- (void)bp_anchorPointChangedToBottomLeft {
    [self bp_anchorPointChangedToPoint:CGPointMake(0, 1)];
}

- (void)bp_anchorPointChangedToBottomCenter {
    [self bp_anchorPointChangedToPoint:CGPointMake(0.5, 1)];
}

- (void)bp_anchorPointChangedToBottomRight {
    [self bp_anchorPointChangedToPoint:CGPointMake(1, 1)];
}

@end
