//
//  UIView+UIView_BlockGesture.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^JKGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (JKBlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)bp_addTapActionWithBlock:(JKGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)bp_addLongPressActionWithBlock:(JKGestureActionBlock)block;
@end
