//
//  UIControl+JKActionBlocks.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIControl+JKActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlJKActionBlockArray = &UIControlJKActionBlockArray;

@implementation UIControlJKActionBlockWrapper

- (void)bp_invokeBlock:(id)sender {
    if (self.bp_actionBlock) {
        self.bp_actionBlock(sender);
    }
}
@end


@implementation UIControl (JKActionBlocks)
-(void)bp_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlJKActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self bp_actionBlocksArray];
    
    UIControlJKActionBlockWrapper *blockActionWrapper = [[UIControlJKActionBlockWrapper alloc] init];
    blockActionWrapper.bp_actionBlock = actionBlock;
    blockActionWrapper.bp_controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(bp_invokeBlock:) forControlEvents:controlEvents];
}


- (void)bp_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self bp_actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlJKActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.bp_controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(bp_invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)bp_actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlJKActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlJKActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end
