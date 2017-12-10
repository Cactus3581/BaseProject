//
//  UIView+UIView_BlockGesture.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+JKBlockGesture.h"
#import <objc/runtime.h>
static char bp_kActionHandlerTapBlockKey;
static char bp_kActionHandlerTapGestureKey;
static char bp_kActionHandlerLongPressBlockKey;
static char bp_kActionHandlerLongPressGestureKey;

@implementation UIView (JKBlockGesture)
- (void)bp_addTapActionWithBlock:(JKGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &bp_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bp_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &bp_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &bp_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)bp_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        JKGestureActionBlock block = objc_getAssociatedObject(self, &bp_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)bp_addLongPressActionWithBlock:(JKGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &bp_kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(bp_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &bp_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &bp_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)bp_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        JKGestureActionBlock block = objc_getAssociatedObject(self, &bp_kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
@end
