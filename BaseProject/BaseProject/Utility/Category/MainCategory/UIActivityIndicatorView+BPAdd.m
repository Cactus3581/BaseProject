//
//  UIActivityIndicatorView+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIActivityIndicatorView+BPAdd.h"
#import "NSObject+BPAdd.h"
#import "UIView+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UIActivityIndicatorView_BPAdd)

@implementation UIActivityIndicatorView (BPAdd)

+ (void)bp_showAnimationInView:(UIView *)view indicatorColor:(UIColor *)color{
    UIActivityIndicatorView *indicator = [view bp_getAssociatedValueForKey:"currentIndicator"];
    if (!indicator) {
        indicator = [UIActivityIndicatorView new];
        indicator.color = color;
//        indicator.center = CGPointMake(view.width / 2.0f, view.height / 2.0f);
        [view addSubview:indicator];
        [view bp_setAssociateValue:indicator withKey:"currentIndicator"];
    }
    if (!indicator.isAnimating) {
        [indicator startAnimating];
    }
}

+ (void)bp_stopAnimationInView:(UIView *)view{
    UIActivityIndicatorView *indicator = [view bp_getAssociatedValueForKey:"currentIndicator"];
    if (indicator) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
        [view bp_removeAssociateWithKey:"currentIndicator"];
    }
}

@end
