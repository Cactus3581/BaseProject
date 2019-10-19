//
//  BPRotatingScreenPushiewController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPRotatingScreenPushiewController.h"

@interface BPRotatingScreenPushiewController ()

@end

@implementation BPRotatingScreenPushiewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.text = @"hi";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //强制横屏的设置
    [self setInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

//必须返回YES
- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}

//如果是push，不会走;模态会走
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
