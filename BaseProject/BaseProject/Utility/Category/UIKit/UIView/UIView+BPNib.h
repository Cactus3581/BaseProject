//
//  UIView+Nib.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (BPNib)

//返回Nib文件
+ (UINib *)bp_loadNib;
+ (UINib *)bp_loadNibNamed:(NSString *)nibName;
+ (UINib *)bp_loadNibNamed:(NSString *)nibName bundle:(NSBundle *)bundle;

//通过Bundle读取view
+ (instancetype)bp_loadInstanceFromNib;
+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

//通过UINib读取view
+ (instancetype)bp_instantiateFromNib;

@end
