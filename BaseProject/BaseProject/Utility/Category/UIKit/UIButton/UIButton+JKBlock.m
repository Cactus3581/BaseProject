//
//  UIButton+Block.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UIButton+JKBlock.h"
#import <objc/runtime.h>
static const void *bp_UIButtonBlockKey = &bp_UIButtonBlockKey;

@implementation UIButton (bp_Block)
-(void)bp_addActionHandler:(JKTouchedButtonBlock)touchHandler{
    objc_setAssociatedObject(self, bp_UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(bp_blockActionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)bp_blockActionTouched:(UIButton *)btn{
    JKTouchedButtonBlock block = objc_getAssociatedObject(self, bp_UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end

