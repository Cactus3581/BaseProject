//
//  UISplitViewController+QuickAccess.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 I often want the "left content view controller" or the "right content view controller".
 Many times the UIViewControllers in viewControllers are actually UINavigationControllers and then
 I want to get the topViewController from that. So these methods pull the left or right VC and then
 check if they are UINavigationControllers. If they are then they go ahead and return the controller's
 topViewController property.
 */

@interface UISplitViewController (JKQuickAccess)

@property (weak, readonly, nonatomic) UIViewController *bp_leftController;
@property (weak, readonly, nonatomic) UIViewController *bp_rightController;

@end
