//
//  BPDrawLayer.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDrawLayer.h"

@implementation BPDrawLayer

#pragma mark - 使用自定义图层绘图

// 触发时机：setNeedsDisplay触发layer的display实例方法
// 方法用途：设置寄宿图
// 如果重写了该实例方法，不会进入后续的方法。比如不会再走layer的delegate代理方法
//- (void)display {
//    [super display];
//    // 可以把CGImage赋给layer的contents，那么会直接把该CGImage作为此layer的样式，不会进入后续的方法
//    self.contents = (__bridge id)[UIImage imageNamed:@"cactus_rect_steady"].CGImage;
//    self.contentsScale = [UIScreen mainScreen].scale;
//}

// 触发时机：如果layer没有设置delegate，或者delegate没有实现displayLayer方法，会调用下面的实例方法
// 方法用途：在方法内部获取ctx并在ctx上绘制。需要调用setNeedDisplay方法
// 如果实现了该方法，不会进入后续的方法。比如不会再走layer的delegate代理方法
// 在调用该方法前，会根据layer 的 bounds 及 contentsScale 创建 backing store，使用CGContextRef指向它 并作为参数传入，backing store替换了之前的contents

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    // 红色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    // 添加圆
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, self.bounds.size.width-20, self.bounds.size.height-20));
    // 实心绘制
    CGContextFillPath(ctx);
}

@end
