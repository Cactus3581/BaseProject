//
//  BPRootTabBarController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRootTabBarController.h"
#import "BPMainNavigationController.h"
#import "BPSYViewController.h"
#import "BPZTViewController.h"
#import "BPXRZViewController.h"

@interface BPRootTabBarController ()

@end

@implementation BPRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self setUpChildViewController:oneVC image:[UIImage imageNamed:@""] title:@"A"];
    BPZTViewController *twoVC = [[BPZTViewController alloc]init];
    [self setUpChildViewController:twoVC image:[UIImage imageNamed:@""] title:@"B"];
    BPSYViewController *threeVC = [[BPSYViewController alloc]init];
    [self setUpChildViewController:threeVC image:[UIImage imageNamed:@""] title:@"C"];
}

/**
 *  添加一个子控制器的方法
 */
- (void)setUpChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title{
    
    viewController.view.backgroundColor = [UIColor whiteColor];
    BPMainNavigationController *navC = [[BPMainNavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = image;
    //    [navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"commentary_num_bg"] forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.title = title;
    [self addChildViewController:navC];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
