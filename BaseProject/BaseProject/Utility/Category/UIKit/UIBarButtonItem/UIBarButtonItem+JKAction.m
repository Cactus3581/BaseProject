//
//  UIBarButtonItem+BPAction.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

char * const UIBarButtonItemBPActionBlock = "UIBarButtonItemBPActionBlock";
#import "UIBarButtonItem+JKAction.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (BPAction)

- (void)bp_performActionBlock {
    
    dispatch_block_t block = self.bp_actionBlock;
    
    if (block)
        block();
    
}

- (BarButtonBPActionBlock)bp_actionBlock {
    return objc_getAssociatedObject(self, UIBarButtonItemBPActionBlock);
}

- (void)setBp_actionBlock:(BarButtonBPActionBlock)actionBlock
 {
    
    if (actionBlock != self.bp_actionBlock) {
        [self willChangeValueForKey:@"bp_actionBlock"];
        
        objc_setAssociatedObject(self,
                                 UIBarButtonItemBPActionBlock,
                                 actionBlock,
                                 OBJC_ASSOCIATION_COPY);
        
        // Sets up the action.
        [self setTarget:self];
        [self setAction:@selector(bp_performActionBlock)];
        
        [self didChangeValueForKey:@"bp_actionBlock"];
    }
}
@end
