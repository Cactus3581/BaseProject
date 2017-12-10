//
//  UITextView+PlaceHolder.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UITextView (JKPlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *bp_placeHolderTextView;
- (void)bp_addPlaceHolder:(NSString *)placeHolder;
@end
