//
//  BPDrawLayer.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDrawLayer.h"

@implementation BPDrawLayer

#pragma mark - 使用自定义图层绘图

// 编写一个类继承于CALayer，重写drawInContext:方法，在方法内部获取ctx并在ctx上绘制。需要调用setNeedDisplay方法
- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    // 红色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    // 添加圆
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, self.bounds.size.width-20, self.bounds.size.height-20));
    // 实心绘制
    CGContextFillPath(ctx);
}

@end
