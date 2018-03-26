//
//  UINavigation+BPFixSpace.m
//  UINavigation-BPFixSpace
//
//  Created by xiaruzhen on 2017/9/8.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UINavigation+BPFixSpace.h"
#import "NSObject+BPAddRuntime.h"
#import <UIKit/UIKit.h>
#import <Availability.h>

#ifndef deviceVersion
#define deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

static BOOL bp_disableFixSpace = NO;
static BOOL bp_tempDisableFixSpace = NO;

@implementation UINavigationController (BPFixSpace)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //FIXME:修正iOS11之后push或者pop动画为NO 系统不主动调用UINavigationBar的layoutSubviews方法
        if (deviceVersion >= 11) {
            [self swizzleInstanceMethodWithOriginSel:@selector(pushViewController:animated:)
                                         swizzledSel:@selector(bp_pushViewController:animated:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(popViewControllerAnimated:)
                                         swizzledSel:@selector(bp_popViewControllerAnimated:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(popToViewController:animated:)
                                         swizzledSel:@selector(bp_popToViewController:animated:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(popToRootViewControllerAnimated:)
                                         swizzledSel:@selector(bp_popToRootViewControllerAnimated:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(setViewControllers:animated:)
                                         swizzledSel:@selector(bp_setViewControllers:animated:)];
        }
    });
}

//FIXME:修正iOS11之后push或者pop动画为NO 系统不主动调用UINavigationBar的layoutSubviews方法
- (void)bp_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self bp_pushViewController:viewController animated:animated];
    if (!animated) {
        [self.navigationBar layoutSubviews];
    }
}

- (nullable UIViewController *)bp_popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [self bp_popViewControllerAnimated:animated];
    if (!animated) {
        [self.navigationBar layoutSubviews];
    }
    return vc;
}

- (nullable NSArray<__kindof UIViewController *> *)bp_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSArray *vcs = [self bp_popToViewController:viewController animated:animated];
    if (!animated) {
        [self.navigationBar layoutSubviews];
    }
    return vcs;
}

- (nullable NSArray<__kindof UIViewController *> *)bp_popToRootViewControllerAnimated:(BOOL)animated{
    NSArray *vcs = [self bp_popToRootViewControllerAnimated:animated];
    if (!animated) {
        [self.navigationBar layoutSubviews];
    }
    return vcs;
}

- (void)bp_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated NS_AVAILABLE_IOS(3_0){
    [self bp_setViewControllers:viewControllers animated:animated];
    if (!animated) {
        [self.navigationBar layoutSubviews];
    }
}

@end

@implementation UINavigationBar (BPFixSpace)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithOriginSel:@selector(layoutSubviews)
                                     swizzledSel:@selector(bp_layoutSubviews)];
    });
}

- (void)bp_layoutSubviews{
    [self bp_layoutSubviews];
    
    if (deviceVersion >= 11 && !bp_disableFixSpace) {//需要调节
        self.layoutMargins = UIEdgeInsetsZero;
        CGFloat space = bp_defaultFixSpace;
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                subview.layoutMargins = UIEdgeInsetsMake(0, space, 0, space);//可修正iOS11之后的偏移
                break;
            }
        }
    }
}

@end

@implementation UINavigationItem (BPFixSpace)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:)
                                     swizzledSel:@selector(bp_setLeftBarButtonItem:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItems:)
                                     swizzledSel:@selector(bp_setLeftBarButtonItems:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:)
                                     swizzledSel:@selector(bp_setRightBarButtonItem:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItems:)
                                     swizzledSel:@selector(bp_setRightBarButtonItems:)];
    });
    
}

- (void)bp_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if (deviceVersion >= 11) {
        [self bp_setLeftBarButtonItem:leftBarButtonItem];
    } else {
        if (!bp_disableFixSpace && leftBarButtonItem) {//存在按钮且需要调节
            [self setLeftBarButtonItems:@[leftBarButtonItem]];
        } else {//不存在按钮,或者不需要调节
            [self bp_setLeftBarButtonItem:leftBarButtonItem];
        }
    }
}

- (void)bp_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    if (leftBarButtonItems.count) {
        NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:bp_defaultFixSpace-20]];//可修正iOS11之前的偏移
        [items addObjectsFromArray:leftBarButtonItems];
        [self bp_setLeftBarButtonItems:items];
    } else {
        [self bp_setLeftBarButtonItems:leftBarButtonItems];
    }
}

- (void)bp_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    if (deviceVersion >= 11) {
        [self bp_setRightBarButtonItem:rightBarButtonItem];
    } else {
        if (!bp_disableFixSpace && rightBarButtonItem) {//存在按钮且需要调节
            [self setRightBarButtonItems:@[rightBarButtonItem]];
        } else {//不存在按钮,或者不需要调节
            [self bp_setRightBarButtonItem:rightBarButtonItem];
        }
    }
}

- (void)bp_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems{
    if (rightBarButtonItems.count) {
        NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:bp_defaultFixSpace-20]];//可修正iOS11之前的偏移
        [items addObjectsFromArray:rightBarButtonItems];
        [self bp_setRightBarButtonItems:items];
    } else {
        [self bp_setRightBarButtonItems:rightBarButtonItems];
    }
}

- (UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
