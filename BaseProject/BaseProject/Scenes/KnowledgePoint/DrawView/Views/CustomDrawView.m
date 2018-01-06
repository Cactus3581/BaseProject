//
//  CustomDrawView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "CustomDrawView.h"
#import "CustomDrawLayer.h"

@implementation CustomDrawView
- (instancetype)initWithFrame:(CGRect)frame
{
    BPLog(@"initWithFrame:");
    if (self = [super initWithFrame:frame]) {
        CustomDrawLayer *layer = [[CustomDrawLayer alloc] init];
        layer.bounds   = CGRectMake(0, 0, 185, 185);
        layer.position = CGPointMake(160, 284);
        layer.backgroundColor = kLightGrayColor.CGColor;
        
        [layer setNeedsDisplay];
        
        [self.layer addSublayer:layer];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    BPLog(@"2-drawRect:");
    //得到当前图形上下文是drawLayer中传递的
    BPLog(@"CGContext:%@",UIGraphicsGetCurrentContext());
    [super drawRect:rect];
}

/*UIView在显示时其根图层会自动创建一个CGContextRef（CALayer本质使用的是位图上下文）
 同时调用图层代理（UIView创建图层会自动设置图层代理为其自身）的draw: inContext:方法
 并将图形上下文作为参数传递给这个方法。
 UIView自动就是根图层的代理*/
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    BPLog(@"1-drawLayer:inContext:");
    BPLog(@"CGContext:%@",ctx);
    [super drawLayer:layer inContext:ctx];
    /*UIView会在这个方法中调用其drawRect:方法*/
}

@end
