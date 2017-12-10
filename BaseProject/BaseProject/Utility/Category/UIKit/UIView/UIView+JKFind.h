//
//  UIView+Find.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (JKFind)
/**
 *  @brief  找到指定类名的SubVie对象
 *
 *  @param clazz SubVie类名
 *
 *  @return view对象
 */
- (id)bp_findSubViewWithSubViewClass:(Class)clazz;
/**
 *  @brief  找到指定类名的SuperView对象
 *
 *  @param clazz SuperView类名
 *
 *  @return view对象
 */
- (id)bp_findSuperViewWithSuperViewClass:(Class)clazz;

/**
 *  @brief  找到并且resign第一响应者
 *
 *  @return 结果
 */
- (BOOL)bp_findAndResignFirstResponder;
/**
 *  @brief  找到第一响应者
 *
 *  @return 第一响应者
 */
- (UIView *)bp_findFirstResponder;

/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *bp_viewController;
@end
