//
//  UIControl+BPActionBlocks.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UIControlBPActionBlock)(id weakSender);


@interface UIControlBPActionBlockWrapper : NSObject
@property (nonatomic, copy) UIControlBPActionBlock bp_actionBlock;
@property (nonatomic, assign) UIControlEvents bp_controlEvents;
- (void)bp_invokeBlock:(id)sender;
@end

@interface UIControl (BPActionBlocks)
- (void)bp_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlBPActionBlock)actionBlock;
- (void)bp_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;
@end
