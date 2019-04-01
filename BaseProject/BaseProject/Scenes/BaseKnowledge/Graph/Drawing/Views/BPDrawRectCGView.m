//
//  BPDrawRectCGView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDrawRectCGView.h"

@implementation BPDrawRectCGView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //获取ctx
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置画图相关样式参数
    
    //设置笔触颜色
    CGContextSetStrokeColorWithColor(ctx, kRedColor.CGColor);
    //设置笔触宽度
    CGContextSetLineWidth(ctx, 5);
    //设置填充色
    CGContextSetFillColorWithColor(ctx, kGreenColor.CGColor);
    /*设置拐点样式
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
    
    [self drawLineWithctx:ctx Rect:rect]; //画线
    [self drawSharpWithctx:ctx Rect:rect];//画矩形、椭圆形、多边形
    [self drawPictureWithctx:ctx Rect:rect];//画图片
    [self drawTextWithctx:ctx Rect:rect];//画文字
}

#pragma mark - 画线
/*
 1. 添加点
 2. 添加点数组
 3. 路径
 */
- (void)drawLineWithctx:(CGContextRef)ctx Rect:(CGRect)rect {

    //画线方法1，使用CGContextAddLineToPoint画线，需要先设置一个起始点
    //设置起始点
    CGContextMoveToPoint(ctx, 10, 10);
    //添加一个点
    CGContextAddLineToPoint(ctx, 10,80);
    //在添加一个点，变成折线
    CGContextAddLineToPoint(ctx, 80, 80);
    
    //画线方法2:构造线路径的点数组
    CGPoint points2[] = {CGPointMake(10, 10),CGPointMake(80, 10),CGPointMake(80, 80)};
    CGContextAddLines(ctx,points2, 3);

    //画线方法3:路径
    //利用路径去画一组点（推荐使用路径的方式，虽然多了几行代码，但是逻辑更清晰了）
    //第一个路径
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, &CGAffineTransformIdentity, 20, 20);
    //CGAffineTransformIdentity 类似于初始化一些参数
    CGPathAddLineToPoint(path1, &CGAffineTransformIdentity, 50, 20);
    CGPathAddLineToPoint(path1, &CGAffineTransformIdentity, 50, 50);
    //路径1加入context
    CGContextAddPath(ctx, path1);
    //path同样有方法CGPathAddLines(),和CGContextAddLines()差不多用法，可以自己试下
    
    //最后：描出笔触
    CGContextStrokePath(ctx);
}

#pragma mark - 画矩形、椭圆形、多边形
- (void)drawSharpWithctx:(CGContextRef)ctx Rect:(CGRect)rect{
    
    //画椭圆，如果长宽相等就是圆
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 10, 50, 80));
    
    //画矩形,长宽相等就是正方形
    CGContextAddRect(ctx, CGRectMake(160, 10, 50, 80));
    
    
    //画多边形，多边形是通过path完成的
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, 240, 10);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 240, 80);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 320, 10);
//    CGPathCloseSubpath(path);//关闭路径
    CGContextAddPath(ctx, path);
    
    //填充
    CGContextFillPath(ctx);
}

#pragma mark - 画图片
- (void)drawPictureWithctx:(CGContextRef)ctx Rect:(CGRect)rect {
    /*图片*/
    UIImage *image = [UIImage imageNamed:@"jobs_youth"];
    [image drawInRect:CGRectMake(kScreenWidth-50, 30, 40, 50)];//在坐标中画出图片
}

#pragma mark - 画文字
- (void)drawTextWithctx:(CGContextRef)ctx Rect:(CGRect)rect {
    //文字样式
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *dict = @{NSFontAttributeName:font,
                           NSForegroundColorAttributeName:kWhiteColor};
    [@"hello world" drawInRect:CGRectMake(kScreenWidth/2.0, self.bounds.size.height/2.0, 100, 30) withAttributes:dict];
}

@end
