//
//  BPShapeLayerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPShapeLayerViewController.h"

#define layer_width 100.0

@interface BPShapeLayerViewController ()
@end

@implementation BPShapeLayerViewController
/*
 
 1. 可动画属性:
 2. 绘制不规则图形：1.直接绘制（drawRect） 2， mask：绘制不规则layer（异步的）；
 3. 测试在mask情况下，贝塞尔曲线的frame，shapelayer的frame，如何受影响:mask父影响-》masklayer影响-》贝塞尔曲线 -进而决定了shapelayer的最终形状。
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self strokeColor];
    [self strokeEnd];
    [self loading_one];  //与CAGradientLayer联合使用，绘制渐变加载条动画
    [self loading_two];
    [self arcLoading]; //扇形动画
}

#pragma mark - 创建shapeLayer - 测试frame的影响
- (void)strokeColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer] ;
    //设置layer的frame，会改变贝塞尔曲线的frame，它根据layer的frame而改变，也就是说它作为子layer存在（在坐标系统上是存在这种父子关系的，其他不是）
    shapeLayer.bounds = CGRectMake(0, 0, layer_width, layer_width);
    shapeLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight-layer_width/2.0-10);
    shapeLayer.backgroundColor = kGreenColor.CGColor;
    // path坐标系统是从layer的左上开始，也就是说path是根据layer的frame的坐标系统；100不是半径，是宽度跟高度。
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 80, 80)];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = kBlueColor.CGColor;
    //重点在线宽
    shapeLayer.lineWidth = 10.0f;
    shapeLayer.strokeColor = kRedColor.CGColor;
    //self.shapeLayer.masksToBounds = YES;
    [self.view.layer addSublayer:shapeLayer];
    //fillcolor没有动画；strokeColor有动画,这样只能在strokeColor上考虑动画了
    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    anmation.fromValue = (id)kRedColor.CGColor;
    anmation.toValue = (id)kGreenColor.CGColor;
    anmation.duration = 2.5;
    anmation.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:anmation forKey:@""];
}

- (void)strokeEnd {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer] ;
    //设置layer的frame，会改变贝塞尔曲线的frame，它根据layer的frame而改变，也就是说它作为子layer存在（在坐标系统上是存在这种父子关系的，其他不是）
    shapeLayer.bounds = CGRectMake(0, 0, layer_width, layer_width);
    shapeLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight-layer_width/2.0-10-layer_width-10);
    shapeLayer.backgroundColor = kGreenColor.CGColor;
    // path坐标系统是从layer的左上开始，也就是说path是根据layer的frame的坐标系统；100不是半径，是宽度跟高度。
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 80, 80)];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = kBlueColor.CGColor;
    //重点在线宽
    shapeLayer.lineWidth = 10.0f;
    shapeLayer.strokeColor = kRedColor.CGColor;
    //self.shapeLayer.masksToBounds = YES;
    [self.view.layer addSublayer:shapeLayer];
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0;
    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmation.fromValue = @0.0;
    anmation.toValue = @1;
    anmation.duration = 2.5;
    anmation.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:anmation forKey:@"strokeEnd"];
}

#pragma mark - 创建shapeLayer - 2 加载条动画、转圈动画(与CAGradientLayer一块使用)
- (void)loading_one {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = CGRectMake(0, 0, layer_width, layer_width);
    gradientLayer.position = CGPointMake(kScreenWidth/2, 50+84) ;
    gradientLayer.cornerRadius = gradientLayer.bounds.size.width/2.0;
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    NSMutableArray *colors = [NSMutableArray array];
    for (int hue  = 0; hue <= 360; hue++) {
        UIColor *color =  hsb(hue / 360.0,1.0,1.0);
        [colors addObject:(id)color.CGColor];
    }
    gradientLayer.colors = colors;
    [self.view.layer addSublayer:gradientLayer];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = gradientLayer.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(gradientLayer.bounds.size.width/2, gradientLayer.bounds.size.width/2) radius:50 startAngle:0 endAngle:M_PI * 2  clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth = 5;
    layer.strokeStart = 0;
    //layer.strokeEnd = 0;
    layer.strokeEnd = 0.8;
    layer.fillColor = kClearColor.CGColor;
    layer.strokeColor = kBlueColor.CGColor;
    
    gradientLayer.mask = layer;
    
    //加载条动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.5;
    animation.fromValue = @0;
    animation.toValue = @0.8;
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - 转圈动画(与CAGradientLayer一块使用)
- (void)loading_two {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = CGRectMake(0, 0, layer_width, layer_width);
    gradientLayer.position = CGPointMake(kScreenWidth/2, 50+84) ;
    gradientLayer.cornerRadius = gradientLayer.bounds.size.width/2.0;
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    NSMutableArray *colors = [NSMutableArray array];
    for (int hue  = 0; hue <= 360; hue++) {
        UIColor *color =  hsb(hue / 360.0,1.0,1.0);
        [colors addObject:(id)color.CGColor];
    }
    gradientLayer.colors = colors;
    [self.view.layer addSublayer:gradientLayer];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = gradientLayer.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(gradientLayer.bounds.size.width/2, gradientLayer.bounds.size.width/2) radius:50 startAngle:0 endAngle:M_PI * 2  clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth = 5;
    layer.strokeStart = 0;
    //layer.strokeEnd = 0;
    layer.strokeEnd = 0.8;
    layer.fillColor = kClearColor.CGColor;
    layer.strokeColor = kBlueColor.CGColor;
    
    gradientLayer.mask = layer;
    
    //转圈动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 2.5;
    animation.fromValue = @0;
    animation.toValue = @(M_PI*2);
    animation.repeatCount = MAXFLOAT;
    [gradientLayer addAnimation:animation forKey:nil];
}

#pragma mark - 创建shapeLayer - 3 -扇形动画，利用lineWidth及strokeEnd
- (void)arcLoading {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    view.center = CGPointMake(kScreenWidth/2.0, 50+84+layer_width+layer_width);
    UIImage *image = [UIImage imageNamed:@"jobs_youth"];
    view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    view.layer.contentsGravity = kCAGravityCenter;
    view.layer.contentsScale = [UIScreen mainScreen].scale;
    view.backgroundColor = kYellowColor;
    //view.layer.masksToBounds =YES; //这句话解释了下面可操作的原因了。
    [self.view addSubview:view];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    /*
     如果设置了mask，那么之前设置这个layer的frame得根据父layer重现设置了。
     结论：跟mask有关系，layer作为mask的子layer，要重新设置贝塞尔曲线的frame,并且如果把作为mask层的子layer添加到self.view.layer上的时候，会移除这个，并作为mask重现布局。
     self.shapeLayer.frame = CGRectMake(0, 0, 100, 100);
     */
    shapeLayer.frame = view.bounds;
    shapeLayer.strokeStart = 0.0f;
    shapeLayer.strokeEnd = 1.0f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = kClearColor.CGColor;
    shapeLayer.strokeColor = kRedColor.CGColor;
    shapeLayer.lineWidth = 100.0f;//重点在线宽
    view.layer.mask = shapeLayer;

    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmation.fromValue = @0.0;
    anmation.toValue = @1;
    anmation.duration = 2.5;
    anmation.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:anmation forKey:@"strokeEnd"];
}

@end
