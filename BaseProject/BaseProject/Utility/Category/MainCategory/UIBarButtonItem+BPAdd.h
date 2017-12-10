//
//  UIBarButtonItem+BPAdd.h
//  WxSelected
//
//  Created by wazrx on 15/12/20.
//  Copyright © 2015年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (BPAdd)

+ (UIBarButtonItem *)bp_itemWithTitle:(NSString *)title clickedHandle:(void(^)(UIBarButtonItem *barButtonItem))clickedConfg;

+ (UIBarButtonItem *)bp_itemWithImage:(NSString *)image highImage:(nullable NSString *)highImage clickedHandle:(void(^)(UIBarButtonItem *barButtonItem))clickedConfg;

@end

NS_ASSUME_NONNULL_END
