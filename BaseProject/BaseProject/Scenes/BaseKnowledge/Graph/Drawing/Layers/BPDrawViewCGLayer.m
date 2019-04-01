//
//  BPDrawViewCGLayer.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDrawViewCGLayer.h"

@implementation BPDrawViewCGLayer

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        
    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
}

// 使用自定义图层绘图：编写一个类继承于CALayer，然后在drawInContext:中使用CGContext绘图。同样需要调用setNeedDisplay方法。
- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    // 红色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    // 添加圆
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, 50, 50));
    // 实心绘制
    CGContextFillPath(ctx);
    
    /*
     
     CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
     CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
     
     CGContextMoveToPoint(ctx, 10, 10);
     // Star Drawing
     CGContextAddLineToPoint(ctx,10, 80);
     CGContextAddLineToPoint(ctx,80, 80);
     CGContextAddLineToPoint(ctx,80, 10);
     CGContextClosePath(ctx);
     
     CGContextDrawPath(ctx, kCGPathFillStroke);
     
     */
}

@end
