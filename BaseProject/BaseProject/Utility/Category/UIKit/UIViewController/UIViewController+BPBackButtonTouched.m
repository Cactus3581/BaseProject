//
//  UIViewController+BackButtonTouched.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIViewController+BPBackButtonTouched.h"
#import <objc/runtime.h>

static const void *BPBackButtonHandlerKey = &BPBackButtonHandlerKey;

@implementation UIViewController (BPBackButtonTouched)

-(void)bp_backButtonTouched:(BPBackButtonHandler)backButtonHandler{
    objc_setAssociatedObject(self, BPBackButtonHandlerKey, backButtonHandler, OBJC_ASSOCIATION_COPY);
}

- (BPBackButtonHandler)bp_backButtonTouched
{
    return objc_getAssociatedObject(self, BPBackButtonHandlerKey);
}
@end

@implementation UINavigationController (ShouldPopItem)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {

	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

   	UIViewController* vc = [self topViewController];
    BPBackButtonHandler handler = [vc bp_backButtonTouched];
    if (handler) {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906

        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(self);
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }

	return NO;
}
@end
