//
//  DrawRect_CG.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "DrawRect_CG.h"

@implementation DrawRect_CG

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //获取ctx
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置画图相关样式参数
    
    //设置笔触颜色
    CGContextSetStrokeColorWithColor(ctx, kRedColor.CGColor);
    //设置笔触宽度
    CGContextSetLineWidth(ctx, 2);
    //设置填充色
    CGContextSetFillColorWithColor(ctx, kGreenColor.CGColor);
    //设置拐点样式
    //    enum CGLineJoin {
    //        kCGLineJoinMiter, //尖的，斜接
    //        kCGLineJoinRound, //圆
    //        kCGLineJoinBevel //斜面
    //    };
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //Line cap 线的两端的样式
    //    enum CGLineCap {
    //        kCGLineCapButt,
    //        kCGLineCapRound,
    //        kCGLineCapSquare
    //    };
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
//    [self drawLineWithctx:ctx Rect:rect]; //画线
//    [self drawSharpWithctx:ctx Rect:rect];//画矩形、椭圆形、多边形
//    [self drawPictureWithctx:ctx Rect:rect];//画图片
//    [self drawTextWithctx:ctx Rect:rect];//画文字

    
    
}

#pragma mark - 画线
-(void)drawLineWithctx:(CGContextRef)ctx Rect:(CGRect)rect{
    //画一条简单的线
//    CGPoint points1[] = {CGPointMake(10, 10),CGPointMake(50, 50)};
//    CGContextAddLines(ctx,points1, 2);
    //画线方法1，使用CGContextAddLineToPoint画线，需要先设置一个起始点
    //设置起始点
//    CGContextMoveToPoint(ctx, 50, 50);
//    //添加一个点
//    CGContextAddLineToPoint(ctx, 100,50);
//    //在添加一个点，变成折线
//    CGContextAddLineToPoint(ctx, 150, 100);
    
    //画线方法2
    //构造线路径的点数组
//    CGPoint points2[] = {CGPointMake(10, 10),CGPointMake(30, 10),CGPointMake(60, 80)};
//    CGContextAddLines(ctx,points2, 3);
    //利用路径去画一组点（推荐使用路径的方式，虽然多了几行代码，但是逻辑更清晰了）
    //第一个路径
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, &CGAffineTransformIdentity, 10, 10);
    //CGAffineTransformIdentity 类似于初始化一些参数
    CGPathAddLineToPoint(path1, &CGAffineTransformIdentity, 500, 80);
    CGPathAddLineToPoint(path1, &CGAffineTransformIdentity, 20, 40);
    //路径1加入context
    CGContextAddPath(ctx, path1);
    //path同样有方法CGPathAddLines(),和CGContextAddLines()差不多用法，可以自己试下
    //描出笔触
    CGContextStrokePath(ctx);
}

#pragma mark - 画矩形、椭圆形、多边形
-(void)drawSharpWithctx:(CGContextRef)ctx Rect:(CGRect)rect{
    
//    //画椭圆，如果长宽相等就是圆
    CGContextAddEllipseInRect(ctx, rect);
    
    
//    //画矩形,长宽相等就是正方形
//    CGContextAddRect(ctx, CGRectMake(5, 5, rect.size.width-5-5, rect.size.width-5-5));
    
    
    //画多边形，多边形是通过path完成的
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, &CGAffineTransformIdentity, 1, 1);
//    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, rect.size.width-1-1, 1);
//    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, rect.size.width-1-1, rect.size.width-1-1);
//    CGPathCloseSubpath(path);
//    CGContextAddPath(ctx, path);
    
    //填充
    CGContextFillPath(ctx);
}


#pragma mark - 画图片
-(void)drawPictureWithctx:(CGContextRef)ctx Rect:(CGRect)rect
{
    /*图片*/
    UIImage *image = [UIImage imageNamed:@"layerTest"];
    [image drawInRect:rect];//在坐标中画出图片
}

#pragma mark - 画文字
-(void)drawTextWithctx:(CGContextRef)ctx Rect:(CGRect)rect
{
    //文字样式
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *dict = @{NSFontAttributeName:font,
                           NSForegroundColorAttributeName:kWhiteColor};
    [@"hello world" drawInRect:rect withAttributes:dict];
}


@end
