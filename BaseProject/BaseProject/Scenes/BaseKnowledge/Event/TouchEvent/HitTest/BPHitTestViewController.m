//
//  BPHitTestViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPHitTestViewController.h"

/*
 1、扩大UIButton的响应热区
 2、子view超出了父view的bounds响应事件
 3、ScrollView page滑动
 */

@interface BPHitTestViewController ()

@end

@implementation BPHitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 边界之外能否响应
- (void)configureViewOut {
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = kClearColor;
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(120);
        make.center.equalTo(self.view);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kGreenColor;
    [backView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(backView);
    }];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kRedColor;
    [rightButton setTitle:@"push" forState:UIControlStateNormal];
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [rightButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.top.equalTo(view).offset(-15);
        make.trailing.equalTo(view.mas_trailing).offset(15);
    }];
    //    view.layer.masksToBounds = YES;
}

#pragma mark - view hidden lauout 依赖
- (void)configureLayout {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    [rightButton setBackgroundImage:[UIImage imageNamed:@"transitionWithType01"] forState:UIControlStateNormal];
    [rightButton setTitle:@"push" forState:UIControlStateNormal];
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:27.0f];
    [rightButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [rightButton.titleLabel sizeToFit];
    rightButton.imageView.layer.masksToBounds = YES;
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [rightButton addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor = kGreenColor;
    [self.view addSubview:rightButton];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(50);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    [bottomButton setBackgroundImage:[UIImage imageNamed:@"transitionWithType01"] forState:UIControlStateNormal];
    [bottomButton setTitle:@"push" forState:UIControlStateNormal];
    [bottomButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:27.0f];
    [bottomButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [bottomButton.titleLabel sizeToFit];
    bottomButton.imageView.layer.masksToBounds = YES;
    bottomButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [bottomButton addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.backgroundColor = kGreenColor;
    [self.view addSubview:bottomButton];
    
    //rightButton.hidden = YES;
    
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightButton).offset(100);
        make.width.height.mas_equalTo(50);
        make.centerX.equalTo(self.view);
    }];
}

- (void)next:(UIButton *)bt {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
