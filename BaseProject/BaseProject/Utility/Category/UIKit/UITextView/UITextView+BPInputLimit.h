//
//  UITextView+BPInputLimit.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (BPInputLimit)
@property (assign, nonatomic)  NSInteger bp_maxLength;//if <=0, no limit
@end
