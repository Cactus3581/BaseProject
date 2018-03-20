//
//  BPViewPropertyController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPViewPropertyController.h"

#define btn_inset (10)
#define btn_bottom (-20)

@interface BPViewPropertyController ()
@property (nonatomic,strong) UIView *testView;
@end

@implementation BPViewPropertyController

//https://www.cnblogs.com/breezemist/p/3457286.html

/*
 
 主要测试transform对view的影响
 当一个view的transform被更改了，即不为CGAffineTransformIdentity。
 
 frame属性可能会更改，view的bounds，center不会变，layer的position不会变。这个很重要，这样保持了在transform后，view的frame虽然改变了，但是内部参考系是不变的，可以继续进行其他变换，只要不更改frame或center或layer的position。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    //3个动画demo
    [self creatTransformButton];
    [self creatMaskButton];
    [self creatResetButton];
    [self creatView];
}

#pragma mark - transform属性
- (void)makeTranslationAction {
    BPLog(@"%@",@(self.testView.frame));
    BPLog(@"%@",@(self.testView.center));
    BPLog(@"%@",@(self.testView.bounds));
    self.testView.transform = CGAffineTransformMakeTranslation(30, 30);
    BPLog(@"%@",@(self.testView.frame));
    BPLog(@"%@",@(self.testView.center));
    BPLog(@"%@",@(self.testView.bounds));
}

- (void)translationAction {
    self.testView.transform = CGAffineTransformTranslate(self.testView.transform, 30, 30);
}

- (void)makeScaleAction {
    self.testView.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (void)scaleAction {
    self.testView.transform = CGAffineTransformScale(self.testView.transform, 0.5, 0.5);
}

- (void)makeRotationAction {
    self.testView.transform = CGAffineTransformMakeRotation(kDegreesToRadian(90));
}

- (void)rotateAction {
    self.testView.transform = CGAffineTransformRotate(self.testView.transform, kDegreesToRadian(45));
}

#pragma mark - mask属性
- (void)maskView {
    UIImage *maskImage = [UIImage imageNamed:@"maskImage"];

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
    //self.testView.maskView = imageView;
}

#pragma mark - reset 重新测试
- (void)reset {
    [self.testView removeFromSuperview];
    self.testView = nil;
    [self creatView];
}

#pragma mark - 创建Button 操作Layer的属性
- (void)creatTransformButton {
    UIButton *transform_makeRotation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeRotation addTarget:self action:@selector(makeRotationAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeRotation setTitle:@"Make旋转" forState:UIControlStateNormal];
    [transform_makeRotation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeRotation.titleLabel.font = [UIFont systemFontOfSize:12];
    transform_makeRotation.backgroundColor = kGreenColor;
    [self.view addSubview:transform_makeRotation];
    
    UIButton *transform_rotation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_rotation addTarget:self action:@selector(rotateAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_rotation setTitle:@"旋转" forState:UIControlStateNormal];
    [transform_rotation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_rotation.titleLabel.font = [UIFont systemFontOfSize:12];
    transform_rotation.backgroundColor = kGreenColor;
    [self.view addSubview:transform_rotation];
    
    UIButton *transform_makeTranslationAction = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeTranslationAction addTarget:self action:@selector(makeTranslationAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeTranslationAction setTitle:@"Make平移" forState:UIControlStateNormal];
    [transform_makeTranslationAction setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeTranslationAction.titleLabel.font = [UIFont systemFontOfSize:12];
    transform_makeTranslationAction.backgroundColor = kGreenColor;
    [self.view addSubview:transform_makeTranslationAction];
    
    UIButton *transform_translation = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_translation addTarget:self action:@selector(translationAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_translation setTitle:@"平移" forState:UIControlStateNormal];
    [transform_translation setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_translation.titleLabel.font = [UIFont systemFontOfSize:12];
    transform_translation.backgroundColor = kGreenColor;
    [self.view addSubview:transform_translation];
    
    UIButton *transform_makeScale = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_makeScale addTarget:self action:@selector(makeScaleAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_makeScale setTitle:@"Make缩放" forState:UIControlStateNormal];
    [transform_makeScale setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_makeScale.titleLabel.font = [UIFont systemFontOfSize:12];
    transform_makeScale.backgroundColor = kGreenColor;
    [self.view addSubview:transform_makeScale];
    
    UIButton *transform_scale = [UIButton buttonWithType:UIButtonTypeSystem];
    [transform_scale addTarget:self action:@selector(scaleAction) forControlEvents:UIControlEventTouchUpInside];
    [transform_scale setTitle:@"缩放" forState:UIControlStateNormal];
    [transform_scale setTitleColor:kBlackColor forState:UIControlStateNormal];
    transform_scale.titleLabel.font = [UIFont systemFontOfSize:12];
    transform_scale.backgroundColor = kGreenColor;
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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(maskView) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Mask" forState:UIControlStateNormal];
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.backgroundColor = kRedColor;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view.mas_bottom).offset(btn_bottom *2);
    }];
}

- (void)creatResetButton {
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setTitle:@"重写运行" forState:UIControlStateNormal];
    [resetButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    resetButton.titleLabel.font = [UIFont systemFontOfSize:12];
    resetButton.backgroundColor = kYellowColor;
    [self.view addSubview:resetButton];
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view.mas_bottom).offset(btn_bottom);
    }];
}

#pragma mark - 创建View
- (void)creatView {
    self.testView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 100)];
    self.testView.backgroundColor = kRedColor;
    UIImage *maskImage1 = [UIImage imageNamed:@"layerTest"];
    self.testView.layer.contents = (__bridge id)maskImage1.CGImage;
    [self.view addSubview:self.testView];
    
    //    UILabel *label = [[UILabel alloc]init];
    //    label.frame =CGRectMake(10, 20, 40, 20);
    //    label.text = @"滑动解锁";
    //    self.testView.layer.mask = label.layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
