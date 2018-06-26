//
//  BPStatusBarViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPStatusBarViewController.h"

@interface BPStatusBarViewController ()
@property (nonatomic ,assign) BOOL statusBarHidden;
@end

//iOS状态栏详解:https://www.jianshu.com/p/4196d7cf95f4

@implementation BPStatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle  = @"animated";
//    [self configStatusBarBackgroundColor_1];
    [self configStatusBarBackgroundColor_2];
    self.statusBarHidden = YES;
    [self setStatusBarAppearanceUpdate];
}

#pragma mark - ios9之前
- (void)discarded {
    //以前：当UIViewControllerBasedStatusBarAppearance对应的value为NO时，[UIApplication sharedApplication] 通过方法setStatusBarStyle对状态栏的设置生效。
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

#pragma mark - 设置背景色-1
- (void)configStatusBarBackgroundColor_1 {
    UIView *statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 20)];
    statusBar.backgroundColor = kExplicitColor;
}

#pragma mark - 设置背景色-2
- (void)configStatusBarBackgroundColor_2 {
    [self.navigationController.navigationBar setBarTintColor:kExplicitColor];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    self.statusBarHidden = !self.statusBarHidden;
    [self setStatusBarAppearanceUpdate];
}

- (void)setStatusBarAppearanceUpdate {
    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

#pragma mark - ios9之后
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

//默认为UIStatusBarAnimationNone，当状态栏隐藏、显示状态发生改变的时候，该函数的返回值就会发挥作用。
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
