//
//  BPViewTransformController.m
//  BaseProject
//
//  Created by Ryan on 2018/1/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPViewTransformController.h"

#define btn_inset (10)
#define btn_bottom (-20)

@interface BPViewTransformController ()

@property (nonatomic,strong) UIView *testView;

@end


@implementation BPViewTransformController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViews];
}

#pragma mark - 平移
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

#pragma mark - 缩放
- (void)makeScaleAction {
    self.testView.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (void)scaleAction {
    self.testView.transform = CGAffineTransformScale(self.testView.transform, 0.5, 0.5);
}

#pragma mark - 旋转
- (void)makeRotationAction {
    self.testView.transform = CGAffineTransformMakeRotation(kDegreesToRadian(90));
}

- (void)rotateAction {
    self.testView.transform = CGAffineTransformRotate(self.testView.transform, kDegreesToRadian(45));
}

#pragma mark - initializeViews
- (void)initializeViews {
    
    self.testView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 100)];
    self.testView.backgroundColor = kRedColor;
    UIImage *maskImage1 = [UIImage imageNamed:@"module_landscape2"];
    self.testView.layer.contents = (__bridge id)maskImage1.CGImage;
    [self.view addSubview:self.testView];
    
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
        make.leading.equalTo(self.view).offset(btn_inset);
        make.bottom.equalTo(self.view).offset(btn_bottom*4);
    }];
    
    [transform_rotation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_makeRotation.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_makeTranslationAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_rotation.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_translation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_makeTranslationAction.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_makeScale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_translation.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
    
    [transform_scale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(transform_makeScale.mas_trailing).offset(btn_inset);
        make.bottom.equalTo(transform_makeRotation.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
