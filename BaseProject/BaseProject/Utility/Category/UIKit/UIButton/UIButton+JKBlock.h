//
//  UIButton+Block.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^JKTouchedButtonBlock)(NSInteger tag);

@interface UIButton (JKBlock)
-(void)bp_addActionHandler:(JKTouchedButtonBlock)touchHandler;
@end
