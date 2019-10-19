//
//  BPStatusBarViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/23.
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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kThemeColor;
    self.rightBarButtonTitle  = @"animated";
    [self setStatusBarBackgroundColor:kPurpleColor];
//    [self setStatusBarBackgroundColorByBarTintColor:kPurpleColor];
//    self.statusBarHidden = YES;
    [self updateStatusBarAppearance];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = kPurpleColor;
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self naviBarHidden:YES animated:animated];
}

#pragma mark - 主动更新statusBar的风格状态
- (void)updateStatusBarAppearance {
    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (void)clickAction {
    self.statusBarHidden = !self.statusBarHidden;
    [self updateStatusBarAppearance];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    self.statusBarHidden = !self.statusBarHidden;
    [self updateStatusBarAppearance];
}

#pragma mark - ios9之前控制statusBar的方法
- (void)discarded {
    //以前：当UIViewControllerBasedStatusBarAppearance对应的value为NO时，[UIApplication sharedApplication] 通过方法setStatusBarStyle对状态栏的设置生效。
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

#pragma mark - 设置Status Bar的背景颜色
/*
 系统状态栏的背景颜色一直是透明的状态：
 当有导航栏时，导航栏背景是什么颜色，状态栏就是什么颜色；
 没有导航栏时，状态栏背后的视图时什么颜色，它就是什么颜色。
 */

//方法一：单独设置Status Bar的背景颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

//方法二：通过设置导航栏颜色，来设置Status Bar的背景颜色，导航栏跟statusBar同颜色
- (void)setStatusBarBackgroundColorByBarTintColor:(UIColor *)color {
    [self.navigationController.navigationBar setBarTintColor:kExplicitColor];
}

#pragma mark - ios9之后：更新statusBar的风格状态的回调
- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

//修改状态栏的字体颜色（字体颜色只有白色和黑色），背景色可以任意设置
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

//默认为UIStatusBarAnimationNone，当状态栏隐藏、显示状态发生改变的时候，该函数的返回值就会发挥作用。
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
