//
//  BPDrawRectView.m
//  BaseProject
//
//  Created by Ryan on 2017/1/23.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPDrawRectView.h"

static CGFloat kWidth = 100;
static CGFloat kHeight = 100;
#define x self.bounds.size.width/2 - 100/2
static CGFloat y = 30;

@implementation BPDrawRectView


#pragma mark - CALayerDelegate

/*
 当UIView显示时：
 view自动创建layer，并自动设置layer的代理为其自身；
 其rootLayer会自动创建一个CGContextRef（本质是位图上下文）;
 接着调用layer代理（view）的drawLayer: inContext:方法，并将图形上下文作为参数传递给这个方法;
 在代理方法里面，默认会调用drawRect:方法；
 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [super drawLayer:layer inContext:ctx];
}

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
    
    //设置填充色：FillColor，前提路径必须是闭合的
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
    
    /*设置虚线
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
    
    //画线
    [self drawLineWithCtx:ctx rect:rect];
    
    //使用贝塞尔曲线画圆
    [self drawBezierPathWithCtx:ctx rect:rect];
    
    //画矩形、椭圆形、多边形
    [self drawSharpWithCtx:ctx rect:rect];
    
    //画图片
    [self drawPictureWithCtx:ctx rect:rect];
    
    //画文字
    [self drawTextWithCtx:ctx rect:rect];
    
    // 画曲线
    [self drawCurveWithCtx:ctx rect:rect];
}

#pragma mark - 画弧
- (void)drawArcWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    //CGContextAddArc:从圆中来创建一个曲线段。需要指定圆心、半径、放射角(以弧度为单位)。放射角为2 PI时，创建的是一个圆
    // CGContextAddArcToPoint:用于给矩形创建内切弧。需要提供圆的半径，每条半径分别与长边和宽边垂直。弧心是两条半径的交叉点
}
    
#pragma mark - 画线
- (void)drawLineWithCtx:(CGContextRef)ctx rect:(CGRect)rect {

    //画线方法1：使用CGContextAddLineToPoint添加点的方式
    //设置起始点，剩下的点是端点
    CGContextMoveToPoint(ctx, x, y);
    //添加一条直线
    CGContextAddLineToPoint(ctx, x,y+kHeight);
    //在添加一个点，变成折线，右下角
    CGContextAddLineToPoint(ctx, x+kWidth, y+kHeight);
    
    CGPoint points[] = {CGPointMake(x, y),CGPointMake(x+kWidth, y),CGPointMake(x+kWidth, y+kHeight)};
    // 添加一系列直线，使用点数组作为函数参数
    CGContextAddLines(ctx,points, 3);

    //画线方法3：使用路径（推荐使用路径的方式）
    CGMutablePathRef path = CGPathCreateMutable();
    //设置路径起点
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, x+kWidth/2, y);
    //绘制直线（从起始位置开始）。CGAffineTransformIdentity 类似于初始化一些参数
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, x, y+kHeight/2);
    //绘制另外一条直线（从上一直线终点开始绘制）
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, x+kWidth/2, y+kHeight);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, x+kWidth, y+kHeight/2);

    //添加路径到图形上下文
    CGContextAddPath(ctx, path);
    // 闭合路径。该函数用一条直接来连接当前点与起始点，以使路径闭合。也可以显式地加一条直线来闭合路径。
    //CGContextClosePath(ctx);

     //指定模式下绘制路径/图像到图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //直接绘制路径/图像到图形上下文
    CGContextStrokePath(ctx);
    
    // release CF对象
    CGPathRelease(path);
}

#pragma mark - 画矩形、椭圆形、多边形
- (void)drawSharpWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    
    //画椭圆，如果长宽相等就是圆
    CGContextAddEllipseInRect(ctx, CGRectMake(x, y*2+kHeight, kWidth/2, kHeight));
    
    //画矩形,长宽相等就是正方形
    CGContextAddRect(ctx, CGRectMake(x, y*3+kHeight*2, kWidth/2, kHeight));
    
    //画多边形，多边形是通过path完成的
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, self.bounds.size.width/2.0, y*4+kHeight*3);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, self.bounds.size.width/4.0, y*4+kHeight*4);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, self.bounds.size.width*3.0/4, y*4+kHeight*4);
    // CGPathCloseSubpath(path);//关闭路径
    CGContextAddPath(ctx, path);
    
    //填充
    CGContextFillPath(ctx);
}

#pragma mark - 画曲线
- (void)drawCurveWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    
// 曲线：二次与三次Bezier曲线是代数曲线。指定起始点、终点、一个或多个控制点。只使用一个控制点，可以创建二次Bezier曲线，只使用两个控制点可以创建出三次Bezier曲线
//    CGContextAddCurveToPoint
//    CGContextAddQuadCurveToPoint
}

#pragma mark - 使用UIKit提供的方法绘制画圆

- (void)drawBezierPathWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    //绘制圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x+kWidth+20, y*2+kHeight, kWidth/2, kHeight)];
    
    //设置填充颜色
    UIColor *fillColor = kExplicitColor;
    [fillColor set];
    [path fill];
    
    //设置画笔颜色,设置线条颜色
    UIColor *stokeColor = kThemeColor;
    [stokeColor set];
    
    //描线 根据坐标连线
    [path stroke];
}

#pragma mark - 画图片
- (void)drawPictureWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"module_landscape2"];
    [image drawInRect:CGRectMake(x,y*5+kHeight*4, kWidth, kHeight)];//在坐标中画出图片
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
