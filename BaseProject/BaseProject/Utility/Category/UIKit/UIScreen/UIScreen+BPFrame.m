//
//  UIScreen+BPFrame.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIScreen+BPFrame.h"

@implementation UIScreen (BPFrame)
+ (CGSize)bp_size {
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)bp_width {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)bp_height {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)bp_orientationSize {
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] doubleValue];
    BOOL isLand =   UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    return (systemVersion>8.0 && isLand) ? bp_SizeSWAP([UIScreen bp_size]) : [UIScreen bp_size];
}

+ (CGFloat)bp_orientationWidth {
    return [UIScreen bp_orientationSize].width;
}

+ (CGFloat)bp_orientationHeight {
    return [UIScreen bp_orientationSize].height;
}

+ (CGSize)bp_DPISize {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}

/**
 *  交换高度与宽度
 */
static inline CGSize bp_SizeSWAP(CGSize size) {
    return CGSizeMake(size.height, size.width);
}

@end
