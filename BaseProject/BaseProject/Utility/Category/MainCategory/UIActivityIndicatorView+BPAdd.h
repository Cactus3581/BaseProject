//
//  UIActivityIndicatorView+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIActivityIndicatorView (BPAdd)

+ (void)bp_showAnimationInView:(UIView *)view indicatorColor:(UIColor *)color;
+ (void)bp_stopAnimationInView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
