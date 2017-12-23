//
//  BPBaseNavigationController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseNavigationController.h"

@interface BPBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.forbiddenInteractivePopGestureRecognizer = NO;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //修复navigationController侧滑关闭失效的问题
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated){
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    if (!self.shouldIgnorePushingViewControllers) {
//        [super pushViewController:viewController animated:animated];
//    }
//    self.shouldIgnorePushingViewControllers = YES;
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (viewController == navigationController.viewControllers.firstObject) {
//        navigationController.interactivePopGestureRecognizer.enabled = NO;
//    } else {
//        if(self.forbiddenInteractivePopGestureRecognizer) {
//            navigationController.interactivePopGestureRecognizer.enabled = NO;
//        } else {
//            navigationController.interactivePopGestureRecognizer.enabled = YES;
//        }
//    }
//    self.shouldIgnorePushingViewControllers = NO;
//}
//
//- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    return [super popToViewController:viewController animated:animated];
//}
//
//- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    return [super popToRootViewControllerAnimated:animated];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
