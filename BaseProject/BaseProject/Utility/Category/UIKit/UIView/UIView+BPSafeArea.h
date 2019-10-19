//
//  UIView+BPSafeArea.h
//  BaseProject
//
//  Created by Ryan on 2017/12/6.
//  Copyright © 2017年 cactus. All rights reserved.
//

/*
 相比直接调用BP方法：
 好处：增加了过滤，避免了重新更新约束
 坏处：需要引用头文件；针对非标准导航栏无法使用
 */

#import <UIKit/UIKit.h>

@interface UIView (BPSafeArea)

/**
 设置导航栏高度
 
 @param constraint vc.view
 */
- (void)updateNaviHeightWithConstraint:(NSLayoutConstraint *)constraint;

/**
 设置底部view居vc.view的bottom
 
 @param constraint vc.view
 */
- (void)updateHomeBarBottomWithConstraint:(NSLayoutConstraint *)constraint;

/**
 设置栏内元素(一般是popButton)的top值
 * top布局的
 
 @param constraint vc.view
 */
- (void)updateStatusBarHeightWithConstraint:(NSLayoutConstraint *)constraint;

/**
 设置栏内元素(一般是popButton)的centerY值
 * 使用CenterY布局的可以使用,bottom布局的不需要修改代码，top布局的往上看
 
 @param constraint vc.view
 */
- (void)updateViewCenterYInNaviWithConstraint:(NSLayoutConstraint *)constraint;

@end
