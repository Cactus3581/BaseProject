//
//  UIView+Recursion.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+BPRecursion.h"

@implementation UIView (BPRecursion)
/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)bp_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse
{
    for( UIView* subview in self.subviews ) {
        BOOL stop = NO;
        if( recurse( subview, &stop ) ) {
            return [subview bp_findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }
    
    return nil;
}


- (void)bp_runBlockOnAllSubviews:(BPSubviewBlock)block
{
    block(self);
    for (UIView* view in [self subviews])
    {
        [view bp_runBlockOnAllSubviews:block];
    }
}

- (void)bp_runBlockOnAllSuperviews:(BPSuperviewBlock)block
{
    block(self);
    if (self.superview)
    {
        [self.superview bp_runBlockOnAllSuperviews:block];
    }
}

- (void)bp_enableAllControlsInViewHierarchy
{
    [self bp_runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:YES];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:YES];
        }
    }];
}

- (void)bp_disableAllControlsInViewHierarchy
{
    [self bp_runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:NO];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:NO];
        }
    }];
}
@end
