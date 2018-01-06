//
//  DrawRect_OC.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "DrawRect_OC.h"

@implementation DrawRect_OC

// 可省略
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//
//
//    }
//    return self;
//}


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


@end
