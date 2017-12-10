//
//  CAShapeLayer+BPUIBezierPath.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//


#import <UIKit/UIKit.h>

#if __has_feature(nullability) // Xcode 6.3+
#pragma clang assume_nonnull begin
#else
#define nullable
#define __nullable
#endif

/**
 Category on `CAShapeLayer`, that allows setting and getting UIBezierPath on CAShapeLayer.
 */
@interface CAShapeLayer (BPUIBezierPath)

/**
 Update CAShapeLayer with UIBezierPath.
 */
- (void)_updateWithBezierPath:(UIBezierPath *)path;

/**
 Get UIBezierPath object, constructed from CAShapeLayer.
 */
- (UIBezierPath*)_bezierPath;

@end

#if __has_feature(nullability)
#pragma clang assume_nonnull end
#endif
