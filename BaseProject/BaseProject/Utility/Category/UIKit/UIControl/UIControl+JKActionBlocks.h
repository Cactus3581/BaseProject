//
//  UIControl+JKActionBlocks.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UIControlJKActionBlock)(id weakSender);


@interface UIControlJKActionBlockWrapper : NSObject
@property (nonatomic, copy) UIControlJKActionBlock bp_actionBlock;
@property (nonatomic, assign) UIControlEvents bp_controlEvents;
- (void)bp_invokeBlock:(id)sender;
@end



@interface UIControl (JKActionBlocks)
- (void)bp_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlJKActionBlock)actionBlock;
- (void)bp_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;
@end
