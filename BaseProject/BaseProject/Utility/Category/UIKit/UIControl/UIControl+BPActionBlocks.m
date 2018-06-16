//
//  UIControl+BPActionBlocks.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIControl+BPActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlBPActionBlockArray = &UIControlBPActionBlockArray;

@implementation UIControlBPActionBlockWrapper

- (void)bp_invokeBlock:(id)sender {
    if (self.bp_actionBlock) {
        self.bp_actionBlock(sender);
    }
}
@end


@implementation UIControl (BPActionBlocks)
- (void)bp_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlBPActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self bp_actionBlocksArray];
    
    UIControlBPActionBlockWrapper *blockActionWrapper = [[UIControlBPActionBlockWrapper alloc] init];
    blockActionWrapper.bp_actionBlock = actionBlock;
    blockActionWrapper.bp_controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(bp_invokeBlock:) forControlEvents:controlEvents];
}


- (void)bp_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self bp_actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlBPActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.bp_controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(bp_invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)bp_actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlBPActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlBPActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end
