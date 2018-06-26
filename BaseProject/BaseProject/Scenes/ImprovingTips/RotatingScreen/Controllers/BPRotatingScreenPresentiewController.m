//
//  BPRotatingScreenPresentiewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPRotatingScreenPresentiewController.h"

@interface BPRotatingScreenPresentiewController ()

@end

@implementation BPRotatingScreenPresentiewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.text = @"hi";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)leftBarButtonItemClickAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//模态弹出ViewController情况下 强制横屏的设置

- (BOOL)shouldAutorotate{
    return YES;
}

//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}

//由模态推出的视图控制器 优先支持的屏幕方向，只有模态才会走
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
