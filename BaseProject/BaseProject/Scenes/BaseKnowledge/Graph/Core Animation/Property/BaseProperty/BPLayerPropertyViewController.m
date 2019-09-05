//
//  BPLayerPropertyViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/8/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPLayerPropertyViewController.h"

@interface BPLayerPropertyViewController ()

@property (nonatomic,weak) CALayer *layer;
@property(nonatomic,weak) UIView *maskView;

@property (nonatomic,strong) CALayer *testLayer;
@property (nonatomic,strong) UIView *testView;

@end


@implementation BPLayerPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
            
            case 0: {
                [self base];
            }
                
            case 1: {
                [self shadow];
            }

            case 2: {
                [self corner];
            }
                
            case 3: {
                [self mask];
            }
                
            case 4: {
                [self anchorPoint];
            }
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //    backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:backView.layer.bounds].CGPath;
}

#pragma mark - 基础属性
- (void)base {
    
#pragma mark - 边框
    
    _layer.borderColor = [UIColor whiteColor].CGColor;
    _layer.borderWidth = 2;
    
#pragma mark - contents
    
    _layer.contents = (id)[UIImage imageNamed:@"image001"].CGImage;
}

#pragma mark - 阴影
- (void)shadow {
    
    _layer.shadowColor = kRedColor.CGColor;//阴影颜色
    _layer.shadowOpacity = 0.5f; //颜色透明度
    _layer.shadowRadius = 5; // 阴影宽度;设置虚化范围程度
    _layer.shadowOffset = CGSizeMake(0, 5); //不露出上边的阴影，左右下露出
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 80)];
    _layer.shadowPath = [path CGPath];
    _layer.shadowPath = [UIBezierPath bezierPathWithRect:_layer.bounds].CGPath;
    _layer.masksToBounds = YES;
}

#pragma mark - 圆角
- (void)corner {
    _layer.cornerRadius = 50;
    
    //    因为UIImageView的Image并不是直接添加在层上面的，而是添加在layer中的contents里。UIImageView中是UIView的主layer上添加了一个次layer（用来绘制contents），我们设置边框的是主layer，但是次layer在上变，不会有任何的影响，所以当我们调用切割语句的时候，超出边框意外的都被切割了！！.
    // //    我们设置层的所有属性它只作用在层上面，对contents里面的东西并不起作用，所以如果我们不进行裁剪，我们是看不到图片的圆角效果的。想要让图片有圆角的效果，就必须把masksToBounds这个属性设为YES，当设为YES，把就会把超过根层以外的东西都给裁剪掉。

    _layer.masksToBounds = YES;
}

#pragma mark - anchorPoint
- (void)anchorPoint {
    CALayer *layer = [CALayer layer];
    //设置尺寸和位置
    layer.frame = CGRectMake(50, 50, 100, 100);
    //设置背景
    layer.backgroundColor = [UIColor redColor].CGColor;
    //给layer设置图片.
    layer.contents = (id)[UIImage imageNamed:@"image001"].CGImage;
    //加载绘制
    [self.view.layer addSublayer:layer];

//    //下面两行代码就是设置views的 正中间 坐标（200，200）
//    _views.layer.position = CGPointMake(200, 200);
//    _views.layer.anchorPoint = CGPointMake(0.5, 0.5);
//
//    //下面两行代码就是设置views的 左上角 坐标（200，200）
//    _views.layer.position = CGPointMake(200, 200);
//    _views.layer.anchorPoint = CGPointMake(0, 0);
//
//    //下面两行代码就是设置views的 右下角 坐标（200，200）
//    _views.layer.position = CGPointMake(200, 200);
//    _views.layer.anchorPoint = CGPointMake(1, 1);
    
}

#pragma mark - mask
- (void)mask {
    
    UIImage *maskImage = [UIImage imageNamed:@"chatMessageBkg"];
    
    //mask的坐标系是根据对象view的
    //第一种 maskLayer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.testView.bounds;
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    //maskLayer.backgroundColor = kWhiteColor.CGColor;//如果mask的背景色为非clearcolor 会完全展现。
    self.testView.layer.mask = maskLayer;
    
    //第二种 maskView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.testView.bounds];
    imageView.frame = CGRectMake(20, 20, 50, 50);
    imageView.image = maskImage;
    self.testView.maskView = imageView;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.bounds];
    
    /*
     关键代码：
     两条路径（UIBezierPath）叠加，内嵌的路径调用bezierPathByReversingPath方法达到反转镂空的效果。相应的，如果我们改变内嵌路径所绘制的形状和位置，我们就可以得到不同的镂空形状的效果，这为适配不同屏幕尺寸引导中的镂空效果提供了很大的方便。
     */
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(kScreenWidth/2-50, kScreenHeight/2, 100, 50) cornerRadius:5] bezierPathByReversingPath]];
    
    // 构造e了一个镂空的layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = kGreenColor.CGColor;
    shapeLayer.strokeColor = kBlueColor.CGColor;
    shapeLayer.lineWidth = 1;
    shapeLayer.path = path.CGPath;
    
    // 当shapeLayer的部分有颜色时，才能看到maskView；关键点是：没有颜色（透明）时看不到maskView，但是能看到maskView.layer的前一个
    [self.testView.layer setMask:shapeLayer];
    
    //[maskView.layer addSublayer:shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
