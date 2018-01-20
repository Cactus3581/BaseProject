//
//  CustomDrawView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDrawView_Layer.h"
#import "BPDrawViewLayer.h"

@implementation BPDrawView_Layer

- (instancetype)init {
    if (self = [super init]) {
        BPDrawViewLayer *layer = [[BPDrawViewLayer alloc] init];
        layer.frame   = CGRectMake(0, 0, 100, 100);
        layer.backgroundColor = kRedColor.CGColor;
        [layer setNeedsDisplay];
        [self.layer addSublayer:layer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //得到当前图形上下文是drawLayer中传递的
    [super drawRect:rect];
}

/*
     UIView在显示时其根图层会自动创建一个CGContextRef（CALayer本质使用的是位图上下文），同时调用图层代理（UIView创建图层会自动设置图层代理为其自身）的draw: inContext:方法，并将图形上下文作为参数传递给这个方法；
     UIView自动就是根图层的代理；
 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    /*UIView会在这个方法中调用其drawRect:方法*/
    [super drawLayer:layer inContext:ctx];
}

@end
