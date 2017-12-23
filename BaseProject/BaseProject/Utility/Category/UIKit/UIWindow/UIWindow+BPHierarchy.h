//
//  UIWindow+BPHierarchy.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (BPHierarchy)
/*!
 @method topMostController
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*)bp_topMostController;

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)bp_currentViewController;
@end
