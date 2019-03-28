//
//  BPDrawLayer_CG.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/23.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDrawLayer_CG.h"

@implementation BPDrawLayer_CG

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    // 红色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    // 添加圆
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, 50, 50));
    // 实心绘制
    CGContextFillPath(ctx);
}

@end
