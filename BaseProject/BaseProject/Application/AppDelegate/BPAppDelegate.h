//
//  BPAppDelegate.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPStatisticsLogView.h"

@interface BPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UITabBarController *rootTabbarViewController;
@property (strong, nonatomic) UIWindow *window;// 获取window
@property (strong, nonatomic) UINavigationController *selectedNavigationController;// 获取导航栏控制器
@property (strong, nonatomic) UIViewController *currentViewController;// 获取当前展示的vc
@property (weak, nonatomic) BPStatisticsLogView *logView; //追踪
@end
