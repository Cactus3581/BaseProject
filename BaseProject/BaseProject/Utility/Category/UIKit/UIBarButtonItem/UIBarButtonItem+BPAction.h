//
//  UIBarButtonItem+BPAction.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BarButtonBPActionBlock)(void);

@interface UIBarButtonItem (BPAction)

/// A block that is run when the UIBarButtonItem is tapped.
//@property (nonatomic, copy) dispatch_block_t actionBlock;
- (void)setBp_actionBlock:(BarButtonBPActionBlock)actionBlock;

@end
