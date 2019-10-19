//
//  UINavigationItem+BPLock.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (BPLock)

/**
 *  @brief  锁定RightItem
 *
 *  @param lock 是否锁定
 */
- (void)bp_lockRightItem:(BOOL)lock;

/**
 *  @brief  锁定LeftItem
 *
 *  @param lock 是否锁定
 */
- (void)bp_lockLeftItem:(BOOL)lock;

@end
