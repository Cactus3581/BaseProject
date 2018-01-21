//
//  BPShapeLayerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPShapeLayerViewController.h"

#define widthBt [UIScreen mainScreen].bounds.size.width/5.0
#define heightBt 30.0

@interface BPShapeLayerViewController ()
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@end

@implementation BPShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testshapeLayer];// 测试在mask情况下，贝塞尔曲线的frame，shapelayer的frame，如何受影响.
    [self creatshapeLayer]; //一般绘制shapelayer的方法
    [self creatshapeLayer_one];  //与CAGradientLayer联合使用，绘制渐变加载条动画
    [self creatshapeLayer_two]; //扇形动画
    [self creatshapeLayer_three]; //绘制起泡-不规则图形
}

#pragma mark - 创建shapeLayer - 测试frame的影响
- (void)testshapeLayer {
    //    //测试1
    self.shapeLayer =[CAShapeLayer layer] ;
    //设置layer的frame，会改变贝塞尔曲线的frame，它根据layer的frame而改变，也就是说它作为子layer存在（在坐标系统上是存在这种父子关系的，其他不是）
    self.shapeLayer.frame = CGRectMake(200, 340, 60, 10);
    self.shapeLayer.backgroundColor = kGreenColor.CGColor;
    
    
    // bezierPathWithOvalInRect:xy坐标也是从左上开始，150不是半径!是宽度跟高度
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 150, 150)];
    
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.fillColor = kBlueColor.CGColor;
    //重点在线宽
    self.shapeLayer.lineWidth = 50.0f;
    self.shapeLayer.strokeColor = kRedColor.CGColor;
    
    //    self.shapeLayer.masksToBounds = YES;
    
    [self.view.layer addSublayer:self.shapeLayer];
    
    
    
    //    //测试2
    //    CALayer *layer =[CALayer layer] ;
    //    layer.frame = CGRectMake(0, 64, 150, 150);
    //    layer.backgroundColor = kGreenColor.CGColor;
    //
    //
    //    CALayer *layer1 =[CALayer layer] ;
    //    layer1.frame = CGRectMake(20, 20, 100, 80);
    ////    layer1.frame = layer.bounds;
    //
    //    layer1.backgroundColor = kRedColor.CGColor;
    //    layer.mask = layer1;
    //    [self.view.layer addSublayer:layer];
    
    
    //测试3:fillcolor没有动画；strokeColor有动画,这样只能在strokeColor上考虑动画了
    //    self.shapeLayer =[CAShapeLayer layer] ;
    //    self.shapeLayer.frame = CGRectMake(60, 100, 150, 150);
    //    [self.view.layer addSublayer:self.shapeLayer];
    //    // bezierPathWithOvalInRect:xy坐标也是从左上开始，150不是半径!是宽度跟高度
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 150, 150)];
    //
    //    self.shapeLayer.path = path.CGPath;
    //    self.shapeLayer.fillColor = kRedColor.CGColor;
    //    //重点在线宽
    //    self.shapeLayer.lineWidth = 3;
    //    self.shapeLayer.strokeColor = kBlueColor.CGColor;
    //    self.shapeLayer.strokeStart = 0;
    //    self.shapeLayer.strokeEnd = 0;
    //
    //
    //    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //    anmation.fromValue = @0.0;
    //    anmation.toValue = @1;
    //    anmation.duration = 2.5;
    //    anmation.repeatCount = MAXFLOAT;
    //    [self.shapeLayer addAnimation:anmation forKey:@""];
    
    
    //    //测试4
    //
    //    CALayer *layer =[CALayer layer] ;
    //    layer.frame = CGRectMake(50, 250, 150, 150);
    //    layer.backgroundColor = kPurpleColor.CGColor;
    //    [self.view.layer addSublayer:layer];
    //
    //
    //    self.shapeLayer =[CAShapeLayer layer] ;
    //    self.shapeLayer.frame = CGRectMake(0, 0, 150, 150);
    ////    self.shapeLayer.backgroundColor = kGreenColor.CGColor;
    //
    //    [layer addSublayer:self.shapeLayer];
    //
    //
    //
    //    // bezierPathWithOvalInRect:xy坐标也是从左上开始，150不是半径!是宽度跟高度
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 150, 150)];
    //
    //    self.shapeLayer.path = path.CGPath;
    //    self.shapeLayer.fillColor = kRedColor.CGColor;
    //    //重点在线宽
    //    self.shapeLayer.lineWidth = 3;
    //    self.shapeLayer.strokeColor = kClearColor.CGColor;
    //
    //    layer.mask = self.shapeLayer;
    //
    //    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //    anmation.fromValue = @0.0;
    //    anmation.toValue = @1;
    //    anmation.duration = 2.5;
    //    anmation.repeatCount = MAXFLOAT;
    //    [self.shapeLayer addAnimation:anmation forKey:@""];
    
    
    //    //测试5
    //    CALayer *layer =[CALayer layer] ;
    //    layer.frame = CGRectMake(50, 250, 150, 150);
    //    layer.backgroundColor = kPurpleColor.CGColor;
    //    [self.view.layer addSublayer:layer];
    //
    //
    //    self.shapeLayer =[CAShapeLayer layer] ;
    //    self.shapeLayer.frame = CGRectMake(0, 0, 150, 150);
    //    [layer addSublayer:self.shapeLayer];
    //
    //    // bezierPathWithOvalInRect:xy坐标也是从左上开始，150不是半径!是宽度跟高度
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(75/2, 75/2, 75, 75)];
    //
    //    self.shapeLayer.path = path.CGPath;
    //    self.shapeLayer.fillColor = kClearColor.CGColor;
    //    //重点在线宽
    //    self.shapeLayer.lineWidth = 75;
    //    self.shapeLayer.strokeColor = kRedColor.CGColor;
    //
    //    layer.mask = self.shapeLayer;
    //
    //    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //    anmation.fromValue = @0.0;
    //    anmation.toValue = @1;
    //    anmation.duration = 2.5;
    //    anmation.repeatCount = MAXFLOAT;
    //    [self.shapeLayer addAnimation:anmation forKey:@""];
    
    //    总结：frame的影响
    //    mask父影响-》masklayer影响-》贝塞尔曲线 -进而决定了shapelayer的最终形状。
}

#pragma mark - 创建shapeLayer - 1 一般用法
- (void)creatshapeLayer {
    /*
     
     只不过要处理好，我们不能创建的CAShapeLayer的frame小于贝塞尔曲线 因为如果这样只要设置了masksToBounds这个属性会把超出部分截掉。
     */
    
    self.shapeLayer =[CAShapeLayer layer] ;
    self.shapeLayer.frame = CGRectMake(0, 0, 80, 150);
    self.shapeLayer.backgroundColor = kGreenColor.CGColor;
    
    //    UIBezierPath  *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    UIBezierPath  *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)];
    
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.strokeColor = kRedColor.CGColor;
    self.shapeLayer.fillColor = kPurpleColor.CGColor;
    
    //描述path路径从哪里开始，这两个值的范围是[0,1]
    
    //    self.shapeLayer.strokeStart = .0;
    //描述path路径从哪里结束
    //    self.shapeLayer.strokeEnd = 0.2;
    
    
    //    self.shapeLayer.masksToBounds = YES;
    
    //    [self.view.layer addSublayer:self.shapeLayer];
    self.view.layer.mask = self.shapeLayer;
    
    //    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //    anmation.fromValue = @0.0;
    //    anmation.toValue = @1;
    //    anmation.duration = 2.5;
    //    anmation.repeatCount = MAXFLOAT;
    //    [self.shapeLayer addAnimation:anmation forKey:@"strokeEnd"];
}

#pragma mark - 创建shapeLayer - 2 加载条动画、转圈动画(与CAGradientLayer一块使用)
- (void)creatshapeLayer_one {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(40, self.view.center.y - 200, 120, 120);
    gradientLayer.position =CGPointMake(kScreenWidth/2, kScreenHeight/2) ;
    
    gradientLayer.cornerRadius = 60;
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    NSMutableArray *colors = [NSMutableArray array];
    for (int hue  = 0; hue <= 360; hue++) {
        UIColor *color =  [UIColor colorWithHue:hue / 360.0 saturation:1.0 brightness:1.0 alpha:1];
        [colors addObject:(id)color.CGColor];
    }
    gradientLayer.colors = colors;
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = gradientLayer.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(gradientLayer.bounds.size.width/2, gradientLayer.bounds.size.width/2) radius:50 startAngle:0 endAngle:M_PI * 2  clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth = 3;
    layer.strokeStart = 0;
    //    layer.strokeEnd = 0;
    layer.strokeEnd = 0.8;
    
    layer.fillColor = kClearColor.CGColor;
    layer.strokeColor = kBlueColor.CGColor;
    //    [self.view.layer addSublayer:layer];
    gradientLayer.mask = layer;
    [self.view.layer addSublayer:gradientLayer];
    
    //加载条动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.5;
    animation.fromValue = @0;
    animation.toValue = @0.8;
    
    [layer addAnimation:animation forKey:nil];
    
    
    //转圈动画
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //    animation.duration = 2.5;
    //    animation.fromValue = @0;
    //    animation.toValue = @(M_PI*2);
    //    animation.repeatCount = MAXFLOAT;
    //
    //    [gradientLayer addAnimation:animation forKey:nil];
}

#pragma mark - 创建shapeLayer - 3 -扇形动画，利用lineWidth及strokeEnd
- (void)creatshapeLayer_two {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    view.center = self.view.center;
    UIImage *image = [UIImage imageNamed:@"layerTest"];
    view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    view.layer.contentsGravity = kCAGravityCenter;
    view.layer.contentsScale = [UIScreen mainScreen].scale;
    view.backgroundColor = kYellowColor;
    //    view.layer.masksToBounds =YES; //这句话解释了下面可操作的原因了。
    [self.view addSubview:view];
    
    self.shapeLayer = [CAShapeLayer layer];
    // 如果设置了mask，那么之前设置这个layer的frame得根据父layer重现设置了。
    
    //结论：跟mask有关系，layer作为mask的子layer，要重新设置贝塞尔曲线的frame,并且如果把作为mask层的子layer添加到self.view.layer上的时候，会移除这个，并作为mask重现布局。
    //    self.shapeLayer.frame = CGRectMake(0, 0, 100, 100);
    self.shapeLayer.frame = view.bounds;
    
    self.shapeLayer.strokeStart = 0.0f;
    self.shapeLayer.strokeEnd = 1.0f;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.fillColor = kClearColor.CGColor;
    //重点在线宽
    self.shapeLayer.lineWidth = 100.0f;
    self.shapeLayer.strokeColor = kRedColor.CGColor;
    view.layer.mask = self.shapeLayer;
    
    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmation.fromValue = @0.0;
    anmation.toValue = @1;
    anmation.duration = 2.5;
    anmation.repeatCount = MAXFLOAT;
    [self.shapeLayer addAnimation:anmation forKey:@"strokeEnd"];
}

#pragma mark - 创建shapeLayer - 3 - 绘制不规则图形
- (void)creatshapeLayer_three {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 100.0f, 100.0f)];
    view.center = self.view.center;
    view.backgroundColor = kGreenColor;
    [self.view addSubview:view];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(30.0f, 30.0f)];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.bounds = view.frame;
    layer.position = CGPointMake(50.0f, 50.0f);
    layer.fillColor = kRedColor.CGColor;
    
    layer.path = path.CGPath;
    view.layer.mask = layer;
    //    [self.view.layer addSublayer:layer];
}

@end
