//
//  UITabBar+BPPrompt.h
//  BaseProject
//
//  Created by Ryan on 2018/10/10.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (BPPrompt)

/**
 展示提示view

 @param index tabbar下标
 */
- (void)showPromptViewOnItemIndex:(NSInteger)index;

/**
 移除提示view
 
 @param index tabbar下标
 */
- (void)removePromptViewOnItemIndex:(NSInteger)index;

/**
 根据下标获取barItem的frame
 
 @param index tabbar下标
 */
- (CGRect)getRectWithTabbarIndex:(NSInteger)index;

/**
 根据下标获取barButton
 
 @param index tabbar下标
 */
- (UIView *)getViewWithTabbarIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
