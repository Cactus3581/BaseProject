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

//绘图只能在此方法中调用，否则无法得到当前图形上下文
-(void)drawRect1:(CGRect)rect{
    //1.取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.创建路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 50);//移动到指定位置（设置路径起点）
    CGPathAddLineToPoint(path, nil, 20, 100);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path, nil, 300, 100);//绘制另外一条直线（从上一直线终点开始绘制）
    
    
    //3.添加路径到图形上下文
    CGContextAddPath(context, path);
    
    //4.设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式,（20,50）和（300,100）是顶点
    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，(20,100)是连接点
    /*设置线段样式
     phase:虚线开始的位置
     lengths:虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
     count:虚线数组元素个数
     */
    CGFloat lengths[2] = { 18, 9 };
    CGContextSetLineDash(context, 0, lengths, 2);
    /*设置阴影
     context:图形上下文
     offset:偏移量
     blur:模糊度
     color:阴影颜色
     */
    CGColorRef color = [UIColor grayColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);
    
    //5.绘制图像到指定图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    
    //6.释放对象
    CGPathRelease(path);
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
