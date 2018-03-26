//
//  BPRootTabBarController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRootTabBarController.h"
#import "BPRootNavigationController.h"
#import "BPBaseKnowledgeViewController.h"
#import "BPImprovingTipViewController.h"
#import "BPFeatureViewController.h"

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
    BPFeatureViewController *featureVC = [[BPFeatureViewController alloc]init];
    [self setUpChildViewController:featureVC image:[UIImage imageNamed:@""] title:@"场景"];
    
    BPBaseKnowledgeViewController *baseKnowledgeVC = [[BPBaseKnowledgeViewController alloc]init];
    [self setUpChildViewController:baseKnowledgeVC image:[UIImage imageNamed:@""] title:@"知识点"];
    
    BPImprovingTipViewController *improvingTipVC = [[BPImprovingTipViewController alloc]init];
    [self setUpChildViewController:improvingTipVC image:[UIImage imageNamed:@""] title:@"技巧"];

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
