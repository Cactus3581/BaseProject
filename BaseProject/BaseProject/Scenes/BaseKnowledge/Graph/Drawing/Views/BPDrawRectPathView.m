//
//  BPDrawRectPathView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDrawRectPathView.h"

@implementation BPDrawRectPathView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

// 得到当前图形上下文是drawLayer中传递的
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //绘制出圆了
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    //设置填充颜色
    UIColor *fillColor = kRedColor;
    [fillColor set];
    [path fill];
    
    //设置画笔颜色
    UIColor *stokeColor = kGreenColor;
    [stokeColor set];
    [path stroke];
}

#pragma mark - CALayerDelegate
/*
 UIView在显示时其根图层会自动创建一个CGContextRef（CALayer本质使用的是位图上下文）;
 同时调用图层代理（UIView创建图层会自动设置图层代理为其自身）的draw: inContext:方法，并将图形上下文作为参数传递给这个方法;
 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    // UIView会在这个方法中调用其drawRect:方法
    [super drawLayer:layer inContext:ctx];
}

@end
