//
//  BPDrawViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/29.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPDrawViewController.h"

#import "BPDrawRect_OC.h"
#import "BPDrawRect_CG.h"
#import "BPDrawLayer_CG.h"

#import "BPDrawView_Layer.h"


@interface BPDrawViewController () <CALayerDelegate>

@end

@implementation BPDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     UIView:  - (void)drawRect:(CGRect)rect
     OC - UIBezierPath
     CG - Point,Path,Image，Text
     */
    [self drawRect_OC];
    [self drawRect_CG];

    /*
     CALayer：- (void)drawInContext:(CGContextRef)ctx
     注意:setNeedsDisplay
     只能用CG方法
     */
    [self drawInContext_CG];

     /*
      UIViewController|UIView：
      代理方法：- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
      注意应该也可以在自定义的view中，添加一个layer，然后实现代理方法
    */
    [self drawLayer_CG_VC];

    /*
     以上都是获取的系统的上下文，在其上画的；
     以下是自己创建图形上下文：UIGraphicsBeginImageContextWithOptions
     */
    [self graphicsBeginImageContextWithOptions_OC];
    [self graphicsBeginImageContextWithOptions_CG];
    [self graphicsBeginImageContextWithOptions];

    
    [self drawViewLayer];
}

- (void)drawViewLayer {
    BPDrawView_Layer *view = [[BPDrawView_Layer alloc] init];
    view.backgroundColor = kLightGrayColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(84));
        make.trailing.equalTo(self.view.mas_trailing).offset(-10);
        make.width.height.equalTo(@(100));
    }];
}

#pragma mark - drawRect_OC - 1.1
- (void)drawRect_OC {
    BPDrawRect_OC *aView =  [[BPDrawRect_OC alloc] init];
    aView.backgroundColor = kLightGrayColor;
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.leading.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(84);
    }];
}

#pragma mark - drawRect_CG - 1.2
- (void)drawRect_CG {
    BPDrawRect_CG *aView =  [[BPDrawRect_CG alloc] init];
    aView.backgroundColor = kLightGrayColor;
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
        make.top.equalTo(self.view).offset(194);
        make.leading.trailing.equalTo(self.view);
    }];
}

#pragma mark -  drawInContext - 2
- (void)drawInContext_CG {
    BPDrawLayer_CG *layer = [BPDrawLayer_CG layer];
    layer.frame = CGRectMake(10, 300, 100, 100);
    layer.backgroundColor = kLightGrayColor.CGColor;
    [layer setNeedsDisplay];// 有这句话才能执行 -drawInContext 和 drawRect 方法
    [self.view.layer addSublayer:layer];
}

#pragma mark - 代理方法 - 3
- (void)drawLayer_CG_VC {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(10, 410, kScreenWidth, 100);
    layer.backgroundColor = kLightGrayColor.CGColor;
    layer.delegate = self; //设置代理
    [layer setNeedsDisplay];// 调用此方法，drawLayer: inContext:方法才会被调用。
    [self.view.layer addSublayer:layer];
}

//代理方法
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //CG-1
    // 1.画一个圆
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, 50, 50));
    // 填充颜色为红色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    // 在context上绘制
    CGContextFillPath(ctx);
    
    //CG-2
    // 2.画一个椭圆
    CGContextAddEllipseInRect(ctx, CGRectMake(80,10,30,60));
    //填充颜色为蓝色
    CGContextSetFillColorWithColor(ctx, kGreenColor.CGColor);
    //在context上绘制
    CGContextFillPath(ctx);
    
    // UIKit-1
    //使用UIKit进行绘制，因为UIKit只会对当前上下文栈顶的context操作，所以要把形参中的context设置为当前上下文
    UIGraphicsPushContext(ctx);
    UIImage* image = [UIImage imageNamed:@"layerTest"];
    //指定位置和大小绘制图片
    [image drawInRect:CGRectMake(140, 10,80 , 80)];
    UIGraphicsPopContext();
}

#pragma mark - UIGraphicsBeginImageContextWithOptions_OC - 4.1
- (void)graphicsBeginImageContextWithOptions_OC {
    //该函数会自动创建一个context，并把它push到上下文栈顶，坐标系也经处理和UIKit的坐标系相同
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, kScreenScale);
    UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    [kGreenColor setFill];
    [path fill];
    //把当前context的内容输出成一个UIImage图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 520, 100, 100)];
    imageView.backgroundColor = kLightGrayColor;
    [imageView setImage:image];
    [self.view addSubview:imageView];
}

#pragma mark - UIGraphicsBeginImageContextWithOptions_CG - 4.2
- (void)graphicsBeginImageContextWithOptions_CG {
    //该函数会自动创建一个context，并把它push到上下文栈顶，坐标系也经处理和UIKit的坐标系相同
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, kScreenScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0,0,100,100));
    //填充颜色为蓝色
    CGContextSetFillColorWithColor(context, kGreenColor.CGColor);
    //在context上绘制
    CGContextFillPath(context);
    //把当前context的内容输出成一个UIImage图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 520, 100, 100)];
    imageView.backgroundColor = kLightGrayColor;
    [imageView setImage:image];
    [self.view addSubview:imageView];
}

#pragma mark - 生成空心图片
- (void)graphicsBeginImageContextWithOptions {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0);
    [kRedColor set];
    CGRect rect = CGRectMake(0, 0, 100, 100);
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(50, 50)];
    [rectPath appendPath:roundPath];
    CGContextAddPath(context, rectPath.CGPath);
    CGContextEOFillPath(context);
    [kGreenColor set];
    UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(50, 50)];
    UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 2, 2) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(50, 50)];
    [borderOutterPath appendPath:borderInnerPath];
    CGContextAddPath(context, borderOutterPath.CGPath);
    CGContextEOFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 520, 100, 100)];
    imageView.backgroundColor = kLightGrayColor;
    [imageView setImage:image];
    [self.view addSubview:imageView];
    
    //测试用的
    UIImageView  *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(250, 320, 100, 100)];
    imageView1.backgroundColor = kYellowColor;
    [imageView1 setImage:image];
//    [self.view addSubview:imageView1];
    
    //UIImageWriteToSavedPhotosAlbum(image, self, nil,nil);//保存图片
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
