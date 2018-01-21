//
//  BPGradientLayerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPGradientLayerViewController.h"

#define widthBt [UIScreen mainScreen].bounds.size.width/5.0
#define heightBt 30.0

@interface BPGradientLayerViewController ()
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,strong) CALayer *test_layer;
@end

@implementation BPGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 渐变色
    [self creatgradientLayer];//颜色渐变-滑动解锁
    [self creatgradientLayer_two];//png渐变
    [self creatgradientLayer_three];//png覆盖图层
}

#pragma mark - 创建gradientLayer 颜色渐变-滑动解锁

/*
 文字渐变实现思路:
 
 1.创建一个颜色渐变层，渐变图层跟文字控件一样大。
 
 2.用文字图层裁剪渐变层，只保留文字部分，就会让渐变层只保留有文字的部分，相当于间接让渐变层显示文字，我们看到的其实是被裁剪过后，渐变层的部分内容。
 
 注意：如果用文字图层裁剪渐变层，文字图层就不在拥有显示功能，这个图层就被弄来裁剪了，不会显示,在下面代码中也会有说明。
 
 2.1 创建一个带有文字的label，label能显示文字。
 
 2.2 设置渐变图层的mask为label图层，就能用文字裁剪渐变图层了。
 
 3.mask图层工作原理: 根据透明度进行裁剪，只保留非透明部分，显示底部内容。
 */
- (void)creatgradientLayer {
    self.view.backgroundColor=kGrayColor;
    
    CAGradientLayer *gradientLayer=[CAGradientLayer layer];
    
    gradientLayer.frame=CGRectMake(30, 200, 200, 66);
    
    //颜色分布范围--渐变颜色的数组
    //    gradientLayer.colors=@[
    //
    //                          (__bridge id)kBlackColor.CGColor,
    //
    //                          (__bridge id)kWhiteColor.CGColor,
    //
    //                          (__bridge id)kBlackColor.CGColor
    //
    //                          ];
    gradientLayer.colors=@[
                           
                           (__bridge id)kRedColor.CGColor,
                           
                           (__bridge id)kGreenColor.CGColor,
                           
                           (__bridge id)kYellowColor.CGColor,
                           (__bridge id)kBlueColor.CGColor,
                           //                          (__bridge id)kPurpleColor.CGColor
                           
                           ];
    
    //设置好 colors 要设置好与之相对应的 locations 值
    
    gradientLayer.locations=@[@.5,@0.9];
    //CAGradientLayer 默认的渐变方向是从上到下，即垂直方向。
    //映射locations中第一个位置，用单位向量表示，比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0)
    //映射locations中最后一个位置，用单位向量表示，比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0)。
    //如果要改变 CAGradientLayer 的渐变方向，则要显式的给 startPoint和 endPoint 两个属性赋值。两个属性共同决定了颜色渐变的方向，如果要改为水平方向，则需要改成:
    
    gradientLayer.startPoint=CGPointMake(0, 0.5);
    
    gradientLayer.endPoint=CGPointMake(1., 0.5);
    
    [self.view.layer addSublayer:gradientLayer];
    
    
    //
    //    //label文字:文字是模型 提供轮廓
    //
    //    UILabel *label=[[UILabel alloc]initWithFrame:gradientLayer.bounds];
    //    // 疑问：label只是用来做文字裁剪，能否不添加到view上。
    //    // 必须要把Label添加到view上，如果不添加到view上，label的图层就不会调用drawRect方法绘制文字，也就没有文字裁剪了。
    //    // 如何验证，自定义Label,重写drawRect方法，看是否调用,发现不添加上去，就不会调用
    //    [self.view addSubview:label];
    //
    //    label.alpha=0.5;
    //
    //    label.text=@"滑动解锁 >>";
    //
    //    label.textAlignment=NSTextAlignmentCenter;
    //
    //    label.font=[UIFont boldSystemFontOfSize:30];
    //    // mask层工作原理:按照透明度裁剪，只保留非透明部分，文字就是非透明的，因此除了文字，其他都被裁剪掉，这样就只会显示文字下面渐变层的内容，相当于留了文字的区域，让渐变层去填充文字的颜色。
    //    // 设置渐变层的裁剪层  注意:一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层
    //    gradientLayer.mask=label.layer;
    //
    //    // 添加色变动画：将keyPath赋值为“locations”是让CAGradientLayer的locations属性做动画，因为locations对应着颜色，那么颜色也会跟着动，最终的显示效果就是：
    //    CABasicAnimation *theAnima=[CABasicAnimation animationWithKeyPath:@"locations"];
    //
    //    theAnima.fromValue=@[@0,@0,@0.25];
    //
    //    theAnima.toValue=@[@0.25,@1,@1];
    //
    //    theAnima.duration=2.5;
    //
    //    theAnima.repeatCount=HUGE;
    
    //    [gradientLayer addAnimation:theAnima forKey:@"locations"];
    
}

#pragma mark - 创建gradientLayer png渐变
- (void)creatgradientLayer_two {
    self.view.backgroundColor = kWhiteColor;
    self.test_layer =[CALayer layer] ;
    self.test_layer.frame = CGRectMake(50, 100, 200, 200);
    UIImage *maskImage1 = [UIImage imageNamed:@"layerTest"];
    self.test_layer.contents = (__bridge id)maskImage1.CGImage;
    self.test_layer.shouldRasterize = YES;
    [self.view.layer addSublayer:self.test_layer];
    
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    gradLayer.frame = self.test_layer.bounds;
    
    //颜色分布范围
    UIColor *startColor = kClearColor;
    UIColor *endColor = kBlueColor;
    gradLayer.colors = @[(id)startColor.CGColor,(id)endColor.CGColor,(id)endColor.CGColor];
    gradLayer.locations = @[@.1,@1];
    
    //颜色渐变方向-从左向右
    //    gradLayer.startPoint = CGPointMake(0, 0.5);
    //    gradLayer.endPoint = CGPointMake(1, 0.5);
    
    self.test_layer.mask = gradLayer;
}

#pragma mark - 创建gradientLayer png覆盖图层
- (void)creatgradientLayer_three {
    //初始化imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"layerTest"]];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    //初始化渐变层
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:self.gradientLayer];
    
    //设置渐变颜色方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设定颜色组
    self.gradientLayer.colors = @[(__bridge id)kClearColor.CGColor,
                                  (__bridge id)kPurpleColor.CGColor];
    //设定颜色分割点
    self.gradientLayer.locations = @[@(0.5f) ,@(1.0f)];
}

@end
