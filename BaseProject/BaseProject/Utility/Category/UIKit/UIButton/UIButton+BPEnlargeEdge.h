//
//  UIButton+EnlargeEdge.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/9/22.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BPEnlargeEdge)

/**
 增大点击区域
 @param size 上左下右的增大量
 */
- (void)bp_setEnlargeEdge:(CGFloat)size;

/**
 增大点击区域
 @param size 上左下右的增大量
 */
- (void)bp_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
