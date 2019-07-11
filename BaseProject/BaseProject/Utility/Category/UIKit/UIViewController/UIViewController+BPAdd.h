//
//  UIViewController+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BPAdd)

- (void)removeSelf_from_naviViewControllers;
- (void)removeMiddleSelfFromParentViewController;

// 设置alertController居左对齐
- (void)setAlertControllerTitleLabelTextAlignment:(NSTextAlignment)textAlignment;

- (UINavigationController*)ks_navigationController;

@end

