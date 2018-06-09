//
//  BPArrowPopView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPArrowPopView.h"
#import "UIView+BPAdd.h"


@implementation BPArrowPopView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = kWhiteColor;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    BPLog(@"正在drawRect...");

    //获取当前图形,视图推入堆栈的图形,相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //
    [kWhiteColor set];
    //创建一个新的空图形路径
    CGContextBeginPath(ctx);

    BPLog(@"开始绘制...");

    //起始位置坐标
    CGFloat origin_x = rect.origin.x;
    CGFloat origin_y = 10; //frame.origin.y + 10;
    //第一条线的位置坐标
    CGFloat line_1_x = rect.size.width - 20;
    CGFloat line_1_y = origin_y;
    //第二条线的位置坐标
    CGFloat line_2_x = line_1_x + 5;
    CGFloat line_2_y = rect.origin.y;
    //第三条线的位置坐标
    CGFloat line_3_x = line_2_x + 5;
    CGFloat line_3_y = line_1_y;
    //第四条线的位置坐标
    CGFloat line_4_x = rect.size.width;
    CGFloat line_4_y = line_1_y;
    //第五条线的位置坐标
    CGFloat line_5_x = rect.size.width;
    CGFloat line_5_y = rect.size.height;
    //第六条线的位置坐标
    CGFloat line_6_x = origin_x;
    CGFloat line_6_y = rect.size.height;

    CGContextMoveToPoint(ctx, origin_x, origin_y);

    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
    CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
    CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
    CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
    CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);

    CGContextClosePath(ctx);

    //设置填充颜色
    UIColor *customColor = [UIColor colorWithWhite:0 alpha:0.8];
    //UIColor *customColor = kLightGrayColor;
    CGContextSetFillColorWithColor(ctx, customColor.CGColor);
    CGContextFillPath(ctx);
}

@end
