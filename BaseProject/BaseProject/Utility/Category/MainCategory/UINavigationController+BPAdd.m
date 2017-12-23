
//
//  UINavigationController+BPAdd.m
//  叮咚(dingdong)
//
//  Created by xiaruzhen on 16/1/31.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import "UINavigationController+BPAdd.h"
#import "UIBarButtonItem+BPAdd.h"
#import "NSObject+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UINavigationController_BPAdd)

@implementation UINavigationController (BPAdd)

+(void)load{
    [self bp_swizzleInstanceMethod:@selector(pushViewController:animated:) with:@selector(_bp_pushViewController:animated:)];
}

/**如果想要手势在边缘不响应始终响应pop事件而不响应有冲突的collectionView事件，可重写collectionView的hitTest方法，进行判断*/

- (void)bp_enableFullScreenGestureWithEdgeSpacing:(CGFloat)edgeSpacing{
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handleNavigationTransition = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handleNavigationTransition];
    [pan bp_setAssociateValue:@(edgeSpacing) withKey:"bp_edgeSpacing"];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGFloat edgeSpacing = [[gestureRecognizer bp_getAssociatedValueForKey:"bp_edgeSpacing"] floatValue];
    if (!edgeSpacing) {
        edgeSpacing = MAXFLOAT;
    }
    if (self.childViewControllers.count == 1 || [gestureRecognizer locationInView:gestureRecognizer.view].x > edgeSpacing || self.view.subviews.lastObject != self.navigationBar) {
        return NO;
    }
    return YES;
}

#pragma mark - getter methods


- (BOOL)hidesBottomBarWhenEveryPushed{
    return [[self bp_getAssociatedValueForKey:"bp_hidesBottomBarWhenPushed"] boolValue];
}

- (UIImage *)customBackImage{
    return [self bp_getAssociatedValueForKey:"bp_customBackImage"];
}

- (BOOL)hideBottomLine{
    return [[self bp_getAssociatedValueForKey:"bp_hideBottomLine"] boolValue];
}

#pragma mark - setter methods

- (void)setHidesBottomBarWhenEveryPushed:(BOOL)hidesBottomBarWhenEveryPushed{
    [self bp_setAssociateValue:@(hidesBottomBarWhenEveryPushed) withKey:"bp_hidesBottomBarWhenPushed"];
}

- (void)setCustomBackImage:(UIImage *)customBackImage{
    [self bp_setAssociateValue:customBackImage withKey:"bp_customBackImage"];
}

- (void)setHideBottomLine:(BOOL)hideBottomLine{
    [self bp_setAssociateValue:@(hideBottomLine) withKey:"bp_hideBottomLine"];
    static UIView *lineView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lineView = [self _bp_findHairlineImageViewUnder:self.navigationBar];
    });
    lineView.hidden = hideBottomLine;
}

#pragma mark - exchange methods


- (void)_bp_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.hidesBottomBarWhenEveryPushed && self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    UIImage *backImage = self.customBackImage;
    if (backImage && self.viewControllers.count > 0) {
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(_bp_back)];
        viewController.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    }
    [self _bp_pushViewController:viewController animated:animated];
}

#pragma mark - private methods

- (void)_bp_back{
    [self popViewControllerAnimated:YES];
}



- (UIImageView *)_bp_findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self _bp_findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
