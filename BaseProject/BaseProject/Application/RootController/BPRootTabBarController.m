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
    [self setTabbarTitleTheme];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/**
 *  添加所有子控制器方法
 */
- (void)configChildViewController{
    BPFeatureViewController *featureVC = [[BPFeatureViewController alloc]init];
    [self setUpChildViewController:featureVC image:[UIImage imageNamed:@"tabbar_hotScenes"] title:@"场景"];
    
    BPBaseKnowledgeViewController *baseKnowledgeVC = [[BPBaseKnowledgeViewController alloc]init];
    [self setUpChildViewController:baseKnowledgeVC image:[UIImage imageNamed:@"tabbar_knowledge"] title:@"知识点"];
    
    BPImprovingTipViewController *improvingTipVC = [[BPImprovingTipViewController alloc]init];
    [self setUpChildViewController:improvingTipVC image:[UIImage imageNamed:@"tabbar_skill"] title:@"技巧"];

    self.delegate = self;
}

/**
 *  添加一个子控制器的方法
 */
- (void)setUpChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title {
    viewController.view.backgroundColor = kWhiteColor;
    BPRootNavigationController *navC = [[BPRootNavigationController alloc] initWithRootViewController:viewController];
    navC.title = title;
    viewController.navigationItem.title = title;
    navC.tabBarItem.image = image;
    navC.tabBarItem.selectedImage = image;
//    navC.tabBarItem.selectedImage = [[[UIImage imageNamed:image] imageWithTintColor:KSColor1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //[navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"commentary_num_bg"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:navC];
}

- (void)setTabbarTitleTheme {
    self.tabBar.translucent = YES;
    self.tabBar.tintColor = kThemeColor;
    //设置不同状态下，字体及颜色
    /*
    UIFont *font = [UIFont systemFontOfSize:10.0];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kWhiteColor,NSFontAttributeName:font} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kWhiteColor,NSFontAttributeName:font} forState:UIControlStateHighlighted];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kWhiteColor,NSFontAttributeName:font} forState:UIControlStateSelected];
    */
    [[UITabBar appearance] setBarTintColor:kWhiteColor];
    //self.tabBar.barTintColor = kThemeColor;

    //绘制tabbar阴影
    /*
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,kThemeColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UITabBar appearance] setShadowImage:img];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
     */
}

@end
