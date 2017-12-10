//
//  UIAlertView+Block.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewBPCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (BPBlock)<UIAlertViewDelegate>

@property (nonatomic, copy) UIAlertViewBPCallBackBlock bp_alertViewCallBackBlock;

+ (void)bp_alertWithCallBackBlock:(UIAlertViewBPCallBackBlock)alertViewCallBackBlock
                            title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName
                otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
