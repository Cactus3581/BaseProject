//
//  UIViewController+BackButtonTouched.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BPBackButtonHandler)(UIViewController *vc);

@interface UIViewController (BPBackButtonTouched)

/**
 *
 *  navgation 返回按钮回调
 *
 *  @param backButtonHandler <#backButtonHandler description#>
 */
-(void)bp_backButtonTouched:(BPBackButtonHandler)backButtonHandler;

@end
