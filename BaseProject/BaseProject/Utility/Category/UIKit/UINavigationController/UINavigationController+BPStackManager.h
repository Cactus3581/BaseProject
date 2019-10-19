//
//  UINavigationController+BPStackManager.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (BPStackManager)

/**
 *  @brief  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)bp_findViewController:(NSString *)className;

/**
 *  @brief  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)bp_isOnlyContainRootViewController;

/**
 *  @brief  RootViewController
 *
 *  @return RootViewController
 */
- (UIViewController *)bp_rootViewController;

/**
 *  @brief  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)bp_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

/**
 *  @brief  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)bp_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;

@end
