//
//  UIView+Recursion.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BPSubviewBlock) (UIView* view);
typedef void (^BPSuperviewBlock) (UIView* superview);
@interface UIView (BPRecursion)

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)bp_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;


- (void)bp_runBlockOnAllSubviews:(BPSubviewBlock)block;
- (void)bp_runBlockOnAllSuperviews:(BPSuperviewBlock)block;
- (void)bp_enableAllControlsInViewHierarchy;
- (void)bp_disableAllControlsInViewHierarchy;
@end
