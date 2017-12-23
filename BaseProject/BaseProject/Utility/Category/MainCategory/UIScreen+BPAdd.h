//
//  UIScreen+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 16/5/17.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (BPAdd)
+ (CGFloat)bp_WidthRatioForIphone6;
+ (CGFloat)bp_heightRatioForIphone6;

/**等同于 [UIScreen mainScreen].bounds*/
+ (CGFloat)bp_screenScale;

/**获取不同方向的屏幕rect*/
- (CGRect)bp_boundsForOrientation:(UIInterfaceOrientation)orientation;
@end

NS_ASSUME_NONNULL_END
