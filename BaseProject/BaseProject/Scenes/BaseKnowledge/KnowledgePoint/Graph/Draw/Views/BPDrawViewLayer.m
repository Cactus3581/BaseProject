//
//  CustomDrawLayer.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDrawViewLayer.h"

@implementation BPDrawViewLayer

//使用自定义图层绘图
//编写一个类继承于CALayer然后在drawInContext:中使用CGContext绘图。同样需要调用setNeedDisplay方法。
- (void)drawInContext:(CGContextRef)ctx {
    BPLog(@"3-drawInContext:");
    CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    
    CGContextMoveToPoint(ctx, 10, 10);
    // Star Drawing
    CGContextAddLineToPoint(ctx,10, 80);
    CGContextAddLineToPoint(ctx,80, 80);
    CGContextAddLineToPoint(ctx,80, 10);
    CGContextClosePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
