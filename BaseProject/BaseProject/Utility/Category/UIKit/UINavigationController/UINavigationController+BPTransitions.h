//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UINavigationController (BPTransitions)

- (void)bp_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;
- (UIViewController *)bp_popViewControllerWithTransition:(UIViewAnimationTransition)transition;

@end
