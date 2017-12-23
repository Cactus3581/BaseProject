//
//  UIControl+BPAdd.h
//  TryCenter
//
//  Created by xiaruzhen on 16/6/5.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (BPAdd)


- (void)bp_addConfig:(void(^)(UIControl *control))config forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
