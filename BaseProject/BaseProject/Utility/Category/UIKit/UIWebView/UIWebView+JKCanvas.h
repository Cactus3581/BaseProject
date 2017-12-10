//
//  UIWebView+Canvas.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIWebView (JKCanvas)
/// 创建一个指定大小的画布
- (void)bp_createCanvas:(NSString *)canvasId
               width:(NSInteger)width
              height:(NSInteger)height;
/// 在指定位置创建一个指定大小的画布
- (void)bp_createCanvas:(NSString *)canvasId
               width:(NSInteger)width
              height:(NSInteger)height
                   x:(NSInteger)x
                   y:(NSInteger)y;
/// 绘制矩形填充 context.fillRect(x,y,width,height)
- (void)bp_fillRectOnCanvas:(NSString *)canvasId
                       x:(NSInteger)x
                       y:(NSInteger)y
                   width:(NSInteger)width
                  height:(NSInteger)height
                 uicolor:(UIColor *)color;
/// 绘制矩形边框 context.strokeRect(x,y,width,height)
- (void)bp_strokeRectOnCanvas:(NSString *)canvasId
                         x:(NSInteger)x
                         y:(NSInteger)y
                     width:(NSInteger)width
                    height:(NSInteger)height
                   uicolor:(UIColor *)color
                 lineWidth:(NSInteger)lineWidth;
/// 清除矩形区域 context.clearRect(x,y,width,height)
- (void)bp_clearRectOnCanvas:(NSString *)canvasId
                        x:(NSInteger)x
                        y:(NSInteger)y
                    width:(NSInteger)width
                   height:(NSInteger) height;
/// 绘制圆弧填充 context.arc(x, y, radius, starAngle,endAngle, anticlockwise)
- (void)bp_arcOnCanvas:(NSString *)canvasId
            centerX:(NSInteger)x
            centerY:(NSInteger)y
             radius:(NSInteger)r
         startAngle:(float)startAngle
           endAngle:(float)endAngle
      anticlockwise:(BOOL)anticlockwise
            uicolor:(UIColor *)color;
/// 绘制一条线段 context.moveTo(x,y) context.lineTo(x,y)
- (void)bp_lineOnCanvas:(NSString *)canvasId
                  x1:(NSInteger)x1
                  y1:(NSInteger)y1
                  x2:(NSInteger)x2
                  y2:(NSInteger)y2
             uicolor:(UIColor *)color
           lineWidth:(NSInteger)lineWidth;
/// 绘制一条折线
- (void)bp_linesOnCanvas:(NSString *)canvasId
               points:(NSArray *)points
             unicolor:(UIColor *)color
            lineWidth:(NSInteger)lineWidth;
/// 绘制贝塞尔曲线 context.bezierCurveTo(cp1x,cp1y,cp2x,cp2y,x,y)
- (void)bp_bezierCurveOnCanvas:(NSString *)canvasId
                         x1:(NSInteger)x1
                         y1:(NSInteger)y1
                       cp1x:(NSInteger)cp1x
                       cp1y:(NSInteger)cp1y
                       cp2x:(NSInteger)cp2x
                       cp2y:(NSInteger)cp2y
                         x2:(NSInteger)x2
                         y2:(NSInteger)y2
                   unicolor:(UIColor *)color
                  lineWidth:(NSInteger)lineWidth;
/// 绘制二次样条曲线 context.quadraticCurveTo(qcpx,qcpy,qx,qy)
// coming soon...
/// 显示图像的一部分 context.drawImage(image,sx,sy,sw,sh,dx,dy,dw,dh)
- (void)bp_drawImage:(NSString *)src
         onCanvas:(NSString *)canvasId
               sx:(NSInteger)sx
               sy:(NSInteger)sy
               sw:(NSInteger)sw
               sh:(NSInteger)sh
               dx:(NSInteger)dx
               dy:(NSInteger)dy
               dw:(NSInteger)dw
               dh:(NSInteger)dh;
@end
