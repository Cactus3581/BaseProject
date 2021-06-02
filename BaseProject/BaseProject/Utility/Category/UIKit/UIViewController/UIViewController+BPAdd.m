//
//  UIViewController+BPAdd.m
//  BaseProject
//
//  Created by Ryan on 2017/9/14.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIViewController+BPAdd.h"

@implementation UIViewController (BPAdd)

- (void)removeSelf_from_naviViewControllers {
    if (self.navigationController) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[self class]]) {
                [array removeObject:obj];
                *stop = YES;
            }
        }];
        self.navigationController.viewControllers = array;
    }
}

- (void)removeMiddleSelfFromParentViewController {
    if (self.navigationController && self.navigationController.viewControllers.count > 0) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        NSMutableArray *vcs = [[[array reverseObjectEnumerator] allObjects] mutableCopy];
        __block BOOL exist = NO;
        [vcs enumerateObjectsUsingBlock:^(UIViewController  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[self class]]) {
                exist = YES;
                [vcs removeObject:obj];
                *stop = YES;
            }
        }];
        if(exist) {
            self.navigationController.viewControllers = [[vcs reverseObjectEnumerator] allObjects];
        }
    }
}

- (void)setAlertControllerTitleLabelTextAlignment:(NSTextAlignment)textAlignment {
    if (![self isKindOfClass:[UIAlertController class]]) {
        return;
    }
    UIView *messageParentView = [self getParentViewOfTitleAndMessageFromView:self.view];
    if (messageParentView && messageParentView.subviews.count > 1) {
        UILabel *messageLb = messageParentView.subviews[1];
        messageLb.textAlignment = textAlignment;
    }
}

- (UIView *)getParentViewOfTitleAndMessageFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            return view;
        }else{
            UIView *resultView = [self getParentViewOfTitleAndMessageFromView:subView];
            if (resultView) return resultView;
        }
    }
    return nil;
}

- (UINavigationController*)bp_navigationController {
    UINavigationController* nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    }
    else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = [((UITabBarController*)self).selectedViewController bp_navigationController];
        }
        else {
            nav = self.navigationController;
        }
    }
    return nav;
}

#pragma mark - 获取顶部视图控制器
//第一种方法：获取当前展示的vc(参数传入导航试图控制器或者UITabBarController,self.window.rootViewController 也可。（这个比较通用）
+ (UIViewController* )bp_currentViewController {
    // Find best view controller
    UIViewController* viewController = kKeyWindow.rootViewController;
    return [self bp_findcurrentViewController:viewController];
}

+ (UIViewController* )bp_findcurrentViewController:(UIViewController*) vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self bp_findcurrentViewController:vc.presentedViewController];

    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self bp_findcurrentViewController:svc.viewControllers.lastObject];
        else
            return vc;

    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self bp_findcurrentViewController:svc.topViewController];
        else
            return vc;

    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self bp_findcurrentViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

//第二种方法：获取顶部视图控制器
+ (UIViewController *)topViewController {
    UIViewController *topVC;
    topVC = [self getTopViewController:[kKeyWindow rootViewController]];
    while (topVC.presentedViewController) {
        topVC = [self getTopViewController:topVC.presentedViewController];
    }
    return topVC;
}

+ (UIViewController *)getTopViewController:(UIViewController *)vc {
    if (![vc isKindOfClass:[UIViewController class]]) {
        return nil;
    } if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getTopViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getTopViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}

@end
