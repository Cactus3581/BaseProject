//
//  CustomLayer_CG.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "CustomLayer_CG.h"

@implementation CustomLayer_CG
- (void)drawInContext:(CGContextRef)ctx
{
    // 红色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    // 添加圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 50, 50));
    // 实心绘制
    CGContextFillPath(ctx);
}
@end
