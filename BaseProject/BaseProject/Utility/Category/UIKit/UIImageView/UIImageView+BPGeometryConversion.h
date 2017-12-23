//
//  UIImageView+GeometryConversion.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (BPGeometryConversion)

- (CGPoint)bp_convertPointFromImage:(CGPoint)imagePoint;
- (CGRect)bp_convertRectFromImage:(CGRect)imageRect;

- (CGPoint)bp_convertPointFromView:(CGPoint)viewPoint;
- (CGRect)bp_convertRectFromView:(CGRect)viewRect;

@end
