//
//  UIViewController+BackButtonTouched.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIViewController+JKBackButtonTouched.h"
#import <objc/runtime.h>
static const void *JKBackButtonHandlerKey = &JKBackButtonHandlerKey;

@implementation UIViewController (JKBackButtonTouched)
-(void)bp_backButtonTouched:(JKBackButtonHandler)backButtonHandler{
    objc_setAssociatedObject(self, JKBackButtonHandlerKey, backButtonHandler, OBJC_ASSOCIATION_COPY);
}
- (JKBackButtonHandler)bp_backButtonTouched
{
    return objc_getAssociatedObject(self, JKBackButtonHandlerKey);
}
@end

@implementation UINavigationController (ShouldPopItem)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {

	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

   	UIViewController* vc = [self topViewController];
    JKBackButtonHandler handler = [vc bp_backButtonTouched];
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
