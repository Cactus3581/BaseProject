//
//  UIView+CustomBorder.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
/**
 * 视图添加边框
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, BPExcludePoint) {
    BPExcludeStartPoint = 1 << 0,
    BPExcludeEndPoint = 1 << 1,
    BPExcludeAllPoint = ~0UL
};


@interface UIView (BPCustomBorder)

- (void)bp_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)bp_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)bp_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)bp_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

- (void)bp_removeTopBorder;
- (void)bp_removeLeftBorder;
- (void)bp_removeBottomBorder;
- (void)bp_removeRightBorder;


- (void)bp_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(BPExcludePoint)edge;
- (void)bp_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(BPExcludePoint)edge;
- (void)bp_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(BPExcludePoint)edge;
- (void)bp_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(BPExcludePoint)edge;
@end
