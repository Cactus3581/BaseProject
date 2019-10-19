//
//  CALayer+BPAdd.h
//  BaseProject
//
//  Created by Ryan on 16/1/28.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (BPAdd)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - snapShot(截图相关)

- (UIImage *)bp_snapshotImage;

- (NSData *)bp_snapshotPDF;

#pragma mark- shadow(阴影相关)

- (void)bp_shadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

#pragma mark - animation(动画相关)

- (void)bp_shakeInBPithDistace:(CGFloat)distance repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration;

- (void)bp_shakeInYWithDistace:(CGFloat)distance repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration;

- (void)bp_rotationInZWithAngle:(CGFloat)angle repeatCount:(NSUInteger)count duration:(NSTimeInterval)duration;

#pragma mark - anchorPoint(锚点相关)

- (void)bp_anchorPointChangedToPoint:(CGPoint)point;

- (void)bp_anchorPointChangedTotopLeft;
- (void)bp_anchorPointChangedTotopCenter;
- (void)bp_anchorPointChangedToTopRight;
- (void)bp_anchorPointChangedToMidLeft;
- (void)bp_anchorPointChangedToMidCenter;
- (void)bp_anchorPointChangedToMidRight;
- (void)bp_anchorPointChangedToBottomLeft;
- (void)bp_anchorPointChangedToBottomCenter;
- (void)bp_anchorPointChangedToBottomRight;

#pragma mark - ohter

- (void)bp_removeAllSublayers;

#pragma mark -  fast property

@property (nonatomic) CGFloat x;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat y;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint center;      ///< Shortcut for center.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size; ///< Shortcut for frame.size.


@property (nonatomic) CGFloat transformRotation;     ///< key path "tranform.rotation"
@property (nonatomic) CGFloat transformRotationX;    ///< key path "tranform.rotation.x"
@property (nonatomic) CGFloat transformRotationY;    ///< key path "tranform.rotation.y"
@property (nonatomic) CGFloat transformRotationZ;    ///< key path "tranform.rotation.z"
@property (nonatomic) CGFloat transformScale;        ///< key path "tranform.scale"
@property (nonatomic) CGFloat transformScaleX;       ///< key path "tranform.scale.x"
@property (nonatomic) CGFloat transformScaleY;       ///< key path "tranform.scale.y"
@property (nonatomic) CGFloat transformScaleZ;       ///< key path "tranform.scale.z"
@property (nonatomic) CGFloat transformTranslationX; ///< key path "tranform.translation.x"
@property (nonatomic) CGFloat transformTranslationY; ///< key path "tranform.translation.y"
@property (nonatomic) CGFloat transformTranslationZ; ///< key path "tranform.translation.z"
@property (nonatomic) CGFloat m34; //, -1/1000 is a good value.It should be set before other transform shortcut."


@end

NS_ASSUME_NONNULL_END
