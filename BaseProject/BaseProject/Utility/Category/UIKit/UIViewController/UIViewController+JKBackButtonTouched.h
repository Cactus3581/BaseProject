//
//  UIViewController+BackButtonTouched.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^JKBackButtonHandler)(UIViewController *vc);
@interface UIViewController (JKBackButtonTouched)
/**
 *
 *  navgation 返回按钮回调
 *
 *  @param backButtonHandler <#backButtonHandler description#>
 */
-(void)bp_backButtonTouched:(JKBackButtonHandler)backButtonHandler;
@end
