//
//  BPCGUtilities.m
//  BaseProject
//
//  Created by Ryan on 2017/12/5.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCGUtilities.h"

//方法实现

/**
 获取bounds
 */
CGRect BPScreenBounds(){
    static CGRect bounds;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bounds = [UIScreen mainScreen].bounds;
    });
    return bounds;
}

/**
 获取宽度比例
 */
CGFloat BPScreenWidthRatio(){
    return [UIScreen mainScreen].bounds.size.width/(375.0f);
}

/**
 获取宽度比例：在横屏下，获取的宽度比例，也是竖屏下的宽度比例
 */
CGFloat BPScreenWidthUniqueRatio(){
    static CGFloat ratio;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize size = [UIScreen mainScreen].bounds.size;
        ratio = [UIScreen mainScreen].bounds.size.width / 375.0f;
        if (size.height < size.width) {
            ratio = size.height / 375.0f;
        }
    });
    return ratio;
    
    /*
     UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
     if (statusBarOrientation==UIInterfaceOrientationLandscapeRight ||statusBarOrientation==UIInterfaceOrientationLandscapeLeft) {
     return [UIScreen mainScreen].bounds.size.height/(375.0);
     }else
     {
     return [UIScreen mainScreen].bounds.size.width/(375.0);
     }
     */
}


/**
 获取size
 */
CGSize BPScreenSize() {
    return [UIScreen mainScreen].bounds.size;
}

/**
 在横屏下。获取的size，也是竖屏下的size，
 */
CGSize BPScreenUniqueSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
    
    /*
     UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
     if (statusBarOrientation==UIInterfaceOrientationLandscapeRight ||statusBarOrientation==UIInterfaceOrientationLandscapeLeft) {
     return [UIScreen mainScreen].bounds.size.width;
     }else
     {
     return [UIScreen mainScreen].bounds.size.height;
     }
     */
}

/**
 缩放系数
 */
CGFloat BPScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}
