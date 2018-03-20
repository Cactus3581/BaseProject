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
@end

@implementation BPLayerViewController

//https://www.cnblogs.com/breezemist/p/3457286.html

/*
 主要测试transform对layer的影响

 当一个view的transform被更改了，即不为CGAffineTransformIdentity。
 
 frame属性可能会更改，view的bounds，center不会变，layer的position不会变。这个很重要，这样保持了在transform后，view的frame虽然改变了，但是内部参考系是不变的，可以继续进行其他变换，只要不更改frame或center或layer的position。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    //3个动画demo
    [self creatTransformButton];
    [self creatMaskButton];
    [self creatResetButton];
    [self creatLayer];// layer基本属性
//    [self setBig];
}

#pragma mark - transform属性
- (void)makeTranslationAction {
    BPLog(@"%@",@(self.testLayer.frame));
    BPLog(@"%@",@(self.testLayer.position));
    BPLog(@"%@",@(self.testLayer.bounds));
    self.testLayer.transform = CATransform3DMakeTranslation(0, 30, 0);
    BPLog(@"%@",@(self.testLayer.frame));
    BPLog(@"%@",@(self.testLayer.position));
    BPLog(@"%@",@(self.testLayer.bounds));
}

- (void)translationAction {
    self.testLayer.transform = CATransform3DTranslate(self.testLayer.transform, 0, 30, 0);
}

- (void)makeScaleAction {
    self.testLayer.transform = CATransform3DMakeScale(0.5f, 0.5f, 1.0f);
}

- (void)scaleAction {
    //self.testLayer.transform = CATransform3DScale(CATransform3DIdentity, 0.5f, 0.5f, 1.0f);
    self.testLayer.transform = CATransform3DScale(self.testLayer.transform, 0.5f, 0.5f, 1.0f);
}

- (void)makeRotationAction {
    //方法一
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeRotation(kDegreesToRadian(45),1, 0, 0);
    transform.m34 = 0.0005;
    self.testLayer.transform =  transform;
}

- (void)scaleRotationAction {
    //方法二
    //旋转也可以用CATransform3DScale，当为负数的时候起到即旋转又缩放的效果
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, -1, 0.5, 1.0);
    self.testLayer.transform =  transform;
}

- (void)rotateAction {
    CATransform3D transform = CATransform3DRotate(self.testLayer.transform, kDegreesToRadian(45), 0, 1, 0);
    transform.m34 = 0.0005;
    self.testLayer.transform =  transform;
}

#pragma mark - mask属性
- (void)maskLayerAction {
    //第一种 maskLayer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.testLayer.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"maskImage"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    self.testLayer.mask = maskLayer;
}

#pragma mark - reset 重新测试
- (void)resetAction {
    self.testLayer.transform =  CATransform3DIdentity;
    [self.testLayer removeFromSuperlayer];
    self.testLayer = nil;
    [self creatLayer];
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
    
    UIButton *transform_scaleRotation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_scaleRotation addTarget:self action:@selector(scaleRotationAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_scaleRotation setTitle:@"scale 缩放+旋转" forState:UIControlStateNormal];
    [transform_scaleRotation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_scaleRotation.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:transform_scaleRotation];
    
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
    
    [transform_scaleRotation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(transform_scale.mas_right).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
}

- (void)creatMaskButton {
    UIButton *mask_layer = [UIButton buttonWithType:UIButtonTypeSystem];
    [mask_layer addTarget:self action:@selector(maskLayerAction) forControlEvents:UIControlEventTouchUpInside];
    [mask_layer setTitle:@"MaskLayer" forState:UIControlStateNormal];
    [mask_layer setTitleColor:kBlackColor forState:UIControlStateNormal];
    mask_layer.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:mask_layer];
    
    [mask_layer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view.mas_bottom).offset(btn_bottom *2);
    }];
}

- (void)creatResetButton {
    UIButton *reset = [UIButton buttonWithType:UIButtonTypeSystem];
    [reset addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    [reset setTitle:@"重写运行" forState:UIControlStateNormal];
    [reset setTitleColor:kBlackColor forState:UIControlStateNormal];
    reset.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:reset];
    
    [reset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view.mas_bottom).offset(btn_bottom);
    }];
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
