//
//  UIBarButtonItem+BPAdd.h
//  BaseProject
//
//  Created by Ryan on 15/12/20.
//  Copyright © 2016年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (BPAdd)

+ (UIBarButtonItem *)bp_itemWithTitle:(NSString *)title clickedHandle:(void(^)(UIBarButtonItem *barButtonItem))clickedConfg;

+ (UIBarButtonItem *)bp_itemWithImage:(NSString *)image highImage:(nullable NSString *)highImage clickedHandle:(void(^)(UIBarButtonItem *barButtonItem))clickedConfg;

@end

NS_ASSUME_NONNULL_END
