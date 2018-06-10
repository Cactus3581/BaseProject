//
//  BPPresentBViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPresentBViewController.h"
#import "BPAppDelegate.h"
#import "BPPresentAViewController.h"
#import "BPPresentCViewController.h"

@interface BPPresentBViewController ()

@end

@implementation BPPresentBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"B";
    self.view.backgroundColor = kThemeColor;
    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [popButton setTitle:@"pop" forState:normal];
    popButton.backgroundColor = kWhiteColor;
    [popButton setTitleColor:kThemeColor forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(dismissViewControllerAnimated) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popButton];
    [popButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setTitle:@"push" forState:normal];
    pushBtn.backgroundColor = kWhiteColor;
    [pushBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
    [pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(popButton.mas_bottom).offset(10);
        make.centerX.equalTo(popButton);
    }];
}

- (void)dismissViewControllerAnimated {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)pushViewController {
    BPPresentCViewController *vc = [[BPPresentCViewController alloc] init];
    [[UIApplication sharedApplication] delegate];
    if (self.navigationController) {
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        UINavigationController *navc = kAppDelegate.selectedNavigationController;
        [self dismissViewControllerAnimated:YES completion:^{
            [navc pushViewController:vc animated:YES];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
