//
//  BPDrawRectLabel.m
//  BaseProject
//
//  Created by Ryan on 2019/9/9.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDrawRectLabel.h"


static CGFloat kWidth = 100;
static CGFloat kHeight = 100;
#define x self.bounds.size.width/2 - 100/2
static CGFloat y = 30;

@implementation BPDrawRectLabel


#pragma mark - 得到当前图形上下文是drawLayer:中传递的
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //取得图形上下文对象
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置上下文状态属性
    //设置笔触颜色：StrokeColor
    
    CGContextSetStrokeColorWithColor(ctx, kThemeColor.CGColor);
    //CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    
    //设置笔触宽度：LineWidth
    CGContextSetLineWidth(ctx, 1);
    
    //设置填充色：FillColor
    CGContextSetFillColorWithColor(ctx, kExplicitColor.CGColor);
    //CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    
    /*设置拐点/连接点样式
     enum CGLineJoin {
     kCGLineJoinMiter, //尖的，斜接
     kCGLineJoinRound, //圆
     kCGLineJoinBevel //斜面
     };
     */
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    
    /*
     Line cap 线的两端的样式
     enum CGLineCap {
     kCGLineCapButt,
     kCGLineCapRound,
     kCGLineCapSquare
     };
     */
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    
    /*设置线段样式
     phase:虚线开始的位置
     lengths:虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
     count:虚线数组元素个数
     */
    CGFloat lengths[2] = {18,9};
    CGContextSetLineDash(ctx, 0, lengths, 2);
    
    /*设置阴影
     context:图形上下文
     offset:偏移量
     blur:模糊度
     color:阴影颜色
     */
    CGColorRef color = kGrayColor.CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
    CGContextSetShadowWithColor(ctx, CGSizeMake(2, 2), 0.8, color);
    

    //画矩形、椭圆形、多边形
    [self drawSharpWithCtx:ctx rect:rect];
    

    
    //画文字
    [self drawTextWithCtx:ctx rect:rect];
}


#pragma mark - 画矩形、椭圆形、多边形
- (void)drawSharpWithCtx:(CGContextRef)ctx rect:(CGRect)rect{
    //画椭圆，如果长宽相等就是圆
    CGContextAddEllipseInRect(ctx, CGRectMake(x, y*2+kHeight, kWidth/2, kHeight));
    //填充
    CGContextFillPath(ctx);
}

#pragma mark - 画文字
- (void)drawTextWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    NSDictionary *dict = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:18],
                           NSForegroundColorAttributeName:kWhiteColor
                           };
    [@"hello world" drawInRect:CGRectMake(x, y*6+kHeight*5, self.bounds.size.width, 50) withAttributes:dict];
}

@end
