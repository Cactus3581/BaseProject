//
//  UIButton+Block.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BPTouchedButtonBlock)(NSInteger tag);

@interface UIButton (BPBlock)

- (void)bp_addActionHandler:(BPTouchedButtonBlock)touchHandler;

@end
