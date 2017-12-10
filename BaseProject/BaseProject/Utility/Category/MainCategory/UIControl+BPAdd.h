//
//  UIControl+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (BPAdd)


- (void)bp_addConfig:(void(^)(UIControl *control))config forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
