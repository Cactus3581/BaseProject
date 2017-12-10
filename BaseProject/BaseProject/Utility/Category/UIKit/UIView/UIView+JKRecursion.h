//
//  UIView+Recursion.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^JKSubviewBlock) (UIView* view);
typedef void (^JKSuperviewBlock) (UIView* superview);
@interface UIView (JKRecursion)

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)bp_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;


-(void)bp_runBlockOnAllSubviews:(JKSubviewBlock)block;
-(void)bp_runBlockOnAllSuperviews:(JKSuperviewBlock)block;
-(void)bp_enableAllControlsInViewHierarchy;
-(void)bp_disableAllControlsInViewHierarchy;
@end
