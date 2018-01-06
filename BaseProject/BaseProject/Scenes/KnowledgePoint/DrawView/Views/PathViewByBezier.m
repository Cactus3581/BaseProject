//
//  PathViewByBezier.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "PathViewByBezier.h"

@implementation PathViewByBezier

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRedColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawCiclePath];
}

- (void)drawCiclePath {
    // 传的是正方形，因此就可以绘制出圆了
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.width - 40)];
    
    // 设置填充颜色
    UIColor *fillColor = kGreenColor;
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = kBlueColor;
    [strokeColor set];
    
    // 根据我们设置的各个点连线
    [path stroke];
}


@end
