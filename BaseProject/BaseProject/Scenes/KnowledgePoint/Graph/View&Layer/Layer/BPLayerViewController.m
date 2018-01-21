//
//  BPLayerViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/1/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPLayerViewController.h"

#define btn_inset (10)
#define btn_bottom (-20)

@interface BPLayerViewController ()
@property (nonatomic,strong) CALayer *testLayer;
@property (nonatomic,strong) UIView *testView;
@property (nonatomic,strong) UIView *view_test;
@end

@implementation BPLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //3个动画demo
    [self creatTransformButton];
    [self creatMaskButton];
    [self creatResetButton];

    [self creatLayer];// layer基本属性
    [self creatView];
//    [self setBig];
}

#pragma mark - transform属性
- (void)makeTranslationAction {
    self.view_test.transform = CGAffineTransformMakeTranslation(30, 30);
}

- (void)translationAction {
    self.view_test.transform = CGAffineTransformTranslate(self.view_test.transform, 30, 30);
}

- (void)makeScaleAction {
    self.view_test.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (void)scaleAction {
    self.view_test.transform = CGAffineTransformScale(self.view_test.transform, 0.5, 0.5);
}

- (void)makeRotationAction {
    //方法一
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeRotation(70/180.0 * M_PI,1, 0, 0);
    transform.m34 = 0.0005;
    self.testLayer.transform =  transform;
    
    //    //方法二
    //    //旋转也可以用CATransform3DScale，当为负数的时候起到即旋转又缩放的效果
    //    CATransform3D transform = CATransform3DIdentity;
    //    transform = CATransform3DScale(transform, -1, -1, 0);
    //    self.testLayer.transform =  transform;
}

- (void)rotateAction {
    CATransform3D transform = CATransform3DRotate(self.testLayer.transform, M_1_PI, 0, 1, 0);
    transform.m34 = 0.0005;
    self.testLayer.transform =  transform;
}

#pragma mark - mask属性
- (void)MaskInLayerBt {
    //第一种 maskLayer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.testLayer.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"maskImage"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    self.testLayer.mask = maskLayer;
}

- (void)MaskInViewBt {
    //第一种 maskLayer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.view_test.bounds;
    
    UIImage *maskImage = [UIImage imageNamed:@"maskImage"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    //如果mask的背景色为非clearcolor 会完全展现。
    //    maskLayer.backgroundColor = kWhiteColor.CGColor;
    self.view_test.layer.mask = maskLayer;
    
    //第二种 maskView
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view_test.bounds];
    image.frame = CGRectMake(20, 20, 50, 50);
    image.image = maskImage;
    //    self.view_test.maskView = image;
}

#pragma mark - reset 重新测试
- (void)resetBt {
    self.testLayer.transform =  CATransform3DIdentity;
    [self.testLayer removeFromSuperlayer];
    self.testLayer = nil;
    [self creatLayer];
}

- (void)resetBt_1 {
    [self.view_test removeFromSuperview];
    self.view_test = nil;
    [self creatView];
}

#pragma mark - 创建testLayer
- (void)creatLayer {
    self.testLayer =[CALayer layer] ;
    self.testLayer.frame = CGRectMake(50, 64, 200, 200);
    UIImage *maskImage1 = [UIImage imageNamed:@"layerTest"];
    self.testLayer.contents = (__bridge id)maskImage1.CGImage;
    self.testLayer.shouldRasterize = YES;
    [self.view.layer addSublayer:self.testLayer];
}

#pragma mark - 创建Button 操作Layer的属性
- (void)creatTransformButton {
    UIButton *transform_makeRotation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeRotation addTarget:self action:@selector(makeRotationAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeRotation setTitle:@"Make旋转" forState:UIControlStateNormal];
    [transform_makeRotation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeRotation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_makeRotation];
    
    UIButton *transform_rotation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_rotation addTarget:self action:@selector(rotateAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_rotation setTitle:@"旋转" forState:UIControlStateNormal];
    [transform_rotation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_rotation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_rotation];

    UIButton *transform_makeTranslationAction = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeTranslationAction addTarget:self action:@selector(makeTranslationAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeTranslationAction setTitle:@"Make平移" forState:UIControlStateNormal];
    [transform_makeTranslationAction setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeTranslationAction.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_makeTranslationAction];
    
    UIButton *transform_translation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_translation addTarget:self action:@selector(translationAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_translation setTitle:@"平移" forState:UIControlStateNormal];
    [transform_translation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_translation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_translation];
    
    UIButton *transform_makeScale = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeScale addTarget:self action:@selector(makeScaleAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeScale setTitle:@"Make缩放" forState:UIControlStateNormal];
    [transform_makeScale setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeScale.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_makeScale];
    
    UIButton *transform_scale = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_scale addTarget:self action:@selector(scaleAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_scale setTitle:@"缩放" forState:UIControlStateNormal];
    [transform_scale setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_scale.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_scale];
    
    [transform_makeRotation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*4);
    }];
    
    [transform_rotation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(transform_makeRotation.mas_right).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_makeTranslationAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(transform_rotation.mas_right).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_translation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(transform_makeTranslationAction.mas_right).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_makeScale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(transform_translation.mas_right).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_scale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(transform_makeScale.mas_right).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
}

- (void)creatMaskButton {
    UIButton *mask_view = [UIButton buttonWithType:UIButtonTypeSystem];
    [mask_view addTarget:self action:@selector(MaskInViewBt) forControlEvents:UIControlEventTouchUpInside];
    [mask_view setTitle:@"Mask" forState:UIControlStateNormal];
    [mask_view setTitleColor:kBlackColor forState:UIControlStateNormal];
    mask_view.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:mask_view];
    
    UIButton *mask_layer = [UIButton buttonWithType:UIButtonTypeSystem];
    [mask_layer addTarget:self action:@selector(MaskInLayerBt) forControlEvents:UIControlEventTouchUpInside];
    [mask_layer setTitle:@"MaskLayer" forState:UIControlStateNormal];
    [mask_layer setTitleColor:kBlackColor forState:UIControlStateNormal];
    mask_layer.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:mask_layer];
    
    [mask_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view.mas_bottom).offset(btn_bottom *2);
    }];
    
    [mask_layer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mask_view.mas_right).offset(btn_inset);
        make.bottom.equalTo(mask_view.mas_bottom);
    }];
}

- (void)creatResetButton {
    UIButton *reset = [UIButton buttonWithType:UIButtonTypeSystem];
    [reset addTarget:self action:@selector(resetBt) forControlEvents:UIControlEventTouchUpInside];
    [reset setTitle:@"重写运行" forState:UIControlStateNormal];
    [reset setTitleColor:kBlackColor forState:UIControlStateNormal];
    reset.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:reset];
    
    UIButton *reset1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [reset1 addTarget:self action:@selector(resetBt_1) forControlEvents:UIControlEventTouchUpInside];
    [reset1 setTitle:@"重写运行" forState:UIControlStateNormal];
    [reset1 setTitleColor:kBlackColor forState:UIControlStateNormal];
    reset1.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:reset1];
    
    [reset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view.mas_bottom).offset(btn_bottom);
    }];
    
    [reset1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(reset.mas_right).offset(btn_inset);
        make.bottom.equalTo(reset.mas_bottom);
    }];
}

#pragma mark - 创建View
- (void)creatView {
    self.view_test = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 100)];
    self.view_test.backgroundColor = kRedColor;
    UIImage *maskImage1 = [UIImage imageNamed:@"layerTest"];
    self.view_test.layer.contents = (__bridge id)maskImage1.CGImage;
    [self.view addSubview:self.view_test];
    
    //    UILabel *label = [[UILabel alloc]init];
    //    label.frame =CGRectMake(10, 20, 40, 20);
    //    label.text = @"滑动解锁";
    //    self.view_test.layer.mask = label.layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setBig {
    self.testView = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 60, 60)];
    self.testView.backgroundColor = kGreenColor;
    self.testView.layer.cornerRadius = 30;
    [self.view addSubview:self.testView];
    [self performSelector:@selector(scan) withObject:nil afterDelay:2.0];
    
    //    CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //    anmation.fromValue = @0.0;
    //    anmation.toValue = @1;
    //    anmation.duration = 2.5;
    //    anmation.repeatCount = MAXFLOAT;
    //    [self.shapeLayer addAnimation:anmation forKey:@""];
}

- (void)scan {
    [self transitionWithType:@"suckEffect" WithSubtype:@"kCATransitionFromRight" ForView:self.testView];
}

- (void) transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view {
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = 0.5;
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}

@end
