//
//  BPDrawViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/29.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPDrawViewController.h"
#import "DrawRect_OC.h"
#import "DrawRect_CG.h"
#import "CustomLayer_CG.h"

@interface BPDrawViewController ()<CALayerDelegate>

@end

@implementation BPDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    
    //2个drawRect方法：- (void)drawRect:(CGRect)rect
    //    [self drawRect_OC];//OC
    [self drawRect_CG];//CG
    
    //在自定义Layer中：- (void)drawInContext:(CGContextRef)ctx
    //    [self drawInContext_CG];//注意:setNeedsDisplay
    
    //代理方法：- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
    //    [self drawLayer_CG_VC];//在ViewController中
    //注意应该也可以在自定义的view中，添加一个layer，然后实现代理方法
    
    
    //创建图形上下文：UIGraphicsBeginImageContextWithOptions
    //    [self graphicsBeginImageContextWithOptions_OC];
    //    [self graphicsBeginImageContextWithOptions_CG];
    
    
}

#pragma mark - drawRect_OC - 1.1
- (void)drawRect_OC
{
    DrawRect_OC *aView =  [[DrawRect_OC alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    //    aView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    aView.backgroundColor = kLightGrayColor;
    [self.view addSubview:aView];
    
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

#pragma mark - drawRect_CG - 1.2
- (void)drawRect_CG
{
    DrawRect_CG *aView =  [[DrawRect_CG alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    aView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    aView.backgroundColor = kLightGrayColor;
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}


#pragma mark -  drawInContext - 2
- (void)drawInContext_CG
{
    CustomLayer_CG *layer = [CustomLayer_CG layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    layer.backgroundColor = kBlueColor.CGColor;
    // 有这句话才能执行 -drawInContext 和 drawRect 方法
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

#pragma mark - 代理方法 - 3
- (void)drawLayer_CG_VC
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    layer.backgroundColor = kBlueColor.CGColor;
    layer.delegate = self; //设置代理
    [layer setNeedsDisplay];// 调用此方法，drawLayer: inContext:方法才会被调用。
    [self.view.layer addSublayer:layer];
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //CG-1
    // 1.画一个圆
    //    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 50, 50));
    //    // 填充颜色为红色
    //    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    //    // 在context上绘制
    //    CGContextFillPath(ctx);
    
    //CG-2
    // 2.画一个椭圆
    //    CGContextAddEllipseInRect(ctx, CGRectMake(0,0,100,100));
    //    //填充颜色为蓝色
    //    CGContextSetFillColorWithColor(ctx, kBlueColor.CGColor);
    //    //在context上绘制
    //    CGContextFillPath(ctx);
    
    // UIKit-1
    //使用UIKit进行绘制，因为UIKit只会对当前上下文栈顶的context操作，所以要把形参中的context设置为当前上下文
    //    UIGraphicsPushContext(ctx);
    //    UIImage* image = [UIImage imageNamed:@"test.png"];
    //    //指定位置和大小绘制图片
    //    [image drawInRect:CGRectMake(0, 0,100 , 100)];
    //    UIGraphicsPopContext();
}




#pragma mark - UIGraphicsBeginImageContextWithOptions_OC - 4.1
- (void)graphicsBeginImageContextWithOptions_OC
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    [kBlueColor setFill];
    [p fill];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [imageView setImage:im];
    [self.view addSubview:imageView];
    
    
    
}

#pragma mark - UIGraphicsBeginImageContextWithOptions_CG - 4.2
- (void)graphicsBeginImageContextWithOptions_CG
{
    //该函数会自动创建一个context，并把它push到上下文栈顶，坐标系也经处理和UIKit的坐标系相同
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0,0,100,100));
    //填充颜色为蓝色
    CGContextSetFillColorWithColor(context, kBlueColor.CGColor);
    //在context上绘制
    CGContextFillPath(context);
    //把当前context的内容输出成一个UIImage图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [imageView setImage:image];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

