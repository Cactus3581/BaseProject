//
//  BPRootTabBarController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRootTabBarController.h"
#import "BPRootNavigationController.h"
#import "BPSYViewController.h"
#import "BPZTViewController.h"
#import "BPXRZViewController.h"

@interface BPRootTabBarController ()

@end

@implementation BPRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self configChildViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/**
 *  添加所有子控制器方法
 */
- (void)configChildViewController{
    BPXRZViewController *oneVC = [[BPXRZViewController alloc]init];
    [self setUpChildViewController:oneVC image:[UIImage imageNamed:@""] title:@"常用场景"];
    BPZTViewController *twoVC = [[BPZTViewController alloc]init];
    [self setUpChildViewController:twoVC image:[UIImage imageNamed:@""] title:@"基本知识点"];
    BPSYViewController *threeVC = [[BPSYViewController alloc]init];
    [self setUpChildViewController:threeVC image:[UIImage imageNamed:@""] title:@"基本知识点"];
}

/**
 *  添加一个子控制器的方法
 */
- (void)setUpChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title {
    viewController.view.backgroundColor = kWhiteColor;
    BPRootNavigationController *navC = [[BPRootNavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = image;
    //    [navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"commentary_num_bg"] forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.title = title;
    [self addChildViewController:navC];
}

@end
