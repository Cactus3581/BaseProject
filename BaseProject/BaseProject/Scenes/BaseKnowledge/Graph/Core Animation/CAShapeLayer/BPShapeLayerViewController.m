//
//  BPShapeLayerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPShapeLayerViewController.h"

static NSInteger kLayerWidth = 100.0;
static NSInteger lineWidth = 10;


@interface BPShapeLayerViewController ()

@property (nonatomic,weak) CAShapeLayer *shapeLayer;

@end


@implementation BPShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0: {
                [self pathFrame];
            }
                break;

            case 1: {
                [self anmationProperty];
            }
                break;

            case 2: {
                [self loading_one];//与CAGradientLayer联合使用，绘制渐变加载条动画
            }
                break;

            case 3: {
                [self loading_two];
            }
                break;

            case 4: {
                [self arcLoading];//扇形动画
            }
                break;
        }
    }
}

- (CAShapeLayer *)shapeLayer {
    if(!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer] ;
        _shapeLayer = shapeLayer;
        shapeLayer.bounds = CGRectMake(0, 0, kLayerWidth, kLayerWidth);
        shapeLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        // 线宽：影响大小和位置，各占一半
        shapeLayer.lineWidth = lineWidth;
        // 使用 fillColor 和 strokeColor 代替 backgroundColor
        shapeLayer.fillColor = kExplicitColor.CGColor;//填充色
        shapeLayer.strokeColor = kThemeColor.CGColor;//边框色
        // shapeLayer.backgroundColor = kGreenColor.CGColor;
        
        // 边缘线的类型
        shapeLayer.lineCap = kCALineCapSquare;
        shapeLayer.strokeStart = 0.0f;
        shapeLayer.strokeEnd = 1.f;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(lineWidth/2.0+5, lineWidth/2.0+5, kLayerWidth-lineWidth-10, kLayerWidth-lineWidth-10)];
        shapeLayer.path = path.CGPath;
        [self.view.layer addSublayer:shapeLayer];
    }
    return _shapeLayer;
}

#pragma mark - CAShapeLayer/path Frame 的影响
- (void)pathFrame {

    // path的坐标系依赖layer的的坐标系，即layer的原点就是path的原点
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(lineWidth/2.0+5, lineWidth/2.0+5, kLayerWidth-lineWidth-10, kLayerWidth-lineWidth-10)];

    // 如果path的大小超出了shapeLayer的bounds，默认不裁剪依然显示完整，可以使用masksToBounds裁剪
    // path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kLayerWidth*2, kLayerWidth*2)];
    // self.shapeLayer.masksToBounds = YES;

    // 圆形的坐标系
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(lineWidth/2.0+5, lineWidth/2.0+5, kLayerWidth-lineWidth-10, kLayerWidth-lineWidth-10)];

    self.shapeLayer.path = path.CGPath;
    
    //    [maskView.layer configMask:CGRectMake(100, 300, 100, 100)];
}

#pragma mark - shapeLayer 的可动画属性

- (void)anmationProperty {
    
    CABasicAnimation *strokeEndAnmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnmation.fromValue = @0.0;
    strokeEndAnmation.toValue = @1;
    strokeEndAnmation.duration = 2.5;
    strokeEndAnmation.repeatCount = MAXFLOAT;
    [self.shapeLayer addAnimation:strokeEndAnmation forKey:@"strokeEnd"];
    
    // 只能在strokeColor上动画，fillcolor没有动画
    CABasicAnimation *strokeColorAnmation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeColorAnmation.fromValue = (id)kRedColor.CGColor;
    strokeColorAnmation.toValue = (id)kGreenColor.CGColor;
    strokeColorAnmation.duration = 2.5;
    strokeColorAnmation.repeatCount = MAXFLOAT;
    [self.shapeLayer addAnimation:strokeColorAnmation forKey:@"strokeColor"];
}

#pragma mark - 加载条动画

- (void)loading_one {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = CGRectMake(0, 0, kLayerWidth, kLayerWidth);
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
    gradientLayer.bounds = CGRectMake(0, 0, kLayerWidth, kLayerWidth);
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

#pragma mark - 扇形动画，利用lineWidth及strokeEnd
- (void)arcLoading {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    view.center = CGPointMake(kScreenWidth/2.0, 50+84+kLayerWidth+kLayerWidth);
    view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"module_landscape2"].CGImage);
    view.layer.contentsGravity = kCAGravityCenter;
    view.layer.contentsScale = [UIScreen mainScreen].scale;
    view.backgroundColor = kYellowColor;
    //view.layer.masksToBounds =YES; //这句话解释了下面可操作的原因了。
    [self.view addSubview:view];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //如果设置了mask，那么之前设置这个layer的frame得根据父layer重现设置了。
    //结论：跟mask有关系，layer作为mask的子layer，要重新设置贝塞尔曲线的frame
    //并且如果把作为mask层的子layer添加到self.view.layer上的时候，会移除这个，并作为mask重现布局。
    // self.shapeLayer.frame = CGRectMake(0, 0, 100, 100);
    shapeLayer.frame = view.bounds;
    shapeLayer.strokeStart = 0.0f;
    shapeLayer.strokeEnd = 1.0f;
    shapeLayer.fillColor = kClearColor.CGColor;
    shapeLayer.strokeColor = kRedColor.CGColor;
    shapeLayer.lineWidth = 100.0f;//重点在线宽
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    shapeLayer.path = path.CGPath;

    view.layer.mask = shapeLayer;

    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmation.fromValue = @0.0;
    anmation.toValue = @1;
    anmation.duration = 2.5;
    anmation.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:anmation forKey:@"strokeEnd"];
}

@end
