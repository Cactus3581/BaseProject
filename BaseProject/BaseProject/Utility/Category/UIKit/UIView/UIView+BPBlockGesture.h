//
//  UIView+UIView_BlockGesture.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BPGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (BPBlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)bp_addTapActionWithBlock:(BPGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)bp_addLongPressActionWithBlock:(BPGestureActionBlock)block;
@end
