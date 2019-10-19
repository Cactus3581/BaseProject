//
//  UIScreen+BPFrame.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (BPFrame)
+ (CGSize)bp_size;
+ (CGFloat)bp_width;
+ (CGFloat)bp_height;

+ (CGSize)bp_orientationSize;
+ (CGFloat)bp_orientationWidth;
+ (CGFloat)bp_orientationHeight;
+ (CGSize)bp_DPISize;

@end
