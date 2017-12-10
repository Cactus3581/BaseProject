//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UINavigationController (JKTransitions)

- (void)bp_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;
- (UIViewController *)bp_popViewControllerWithTransition:(UIViewAnimationTransition)transition;

@end
