//
//  BPBaseTabBarController.m
//  BaseProject
//
//  Created by Ryan on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseTabBarController.h"

@interface BPBaseTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic,strong) NSDate *lastClickDate;
@end

@implementation BPBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([self doubleClick]) {
        UINavigationController *navigation =(UINavigationController *)viewController;
        PerformSelectorLeakWarningIgnore(
             if ([navigation.topViewController respondsToSelector:@selector(tabbarDoubleClick)]) {
                 [navigation.topViewController performSelector:@selector(tabbarDoubleClick)];
             }
        );
    }
}

#pragma mark - 双击事件
- (BOOL)doubleClick {
    NSDate *date = [NSDate date];
    if (date.timeIntervalSince1970 - self.lastClickDate.timeIntervalSince1970 < 0.5) {
        //完成一次双击后，重置第一次单击的时间，区分3次或多次的单击
        self.lastClickDate = [NSDate dateWithTimeIntervalSince1970:0];
        return YES;
    }
    self.lastClickDate = date;
    return NO;
}

#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

#pragma mark - statusBar

/*
 解释一下为什么嵌套UITabBarController/UINavigationController的viewController的preferredStatusBarStyle函数设置无效：
 在我们嵌套了UINavigationController的时候，我们的AppDelegate.window.rootViewController通常是我们创建的UITabBarController，这时首先会调用的是UITabBarController中的childViewControllerForStatusBarStyle函数，因为默认返回nil，那么接下来就会调用UITabBarController本身的preferredStatusBarStyle函数，所以我们在viewController中通过preferredStatusBarStyle函数设置的状态栏样式就不会被调用发现，所以也就无效了。
 所以我们要自己创建一个继承于UITabBarController的UITabBarController，在这个子类中重写childViewControllerForStatusBarStyle函数
 */

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.selectedViewController;
}

- (BOOL)prefersStatusBarHidden {
    return [self.selectedViewController prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.selectedViewController preferredStatusBarStyle];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return [self.selectedViewController preferredStatusBarUpdateAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
