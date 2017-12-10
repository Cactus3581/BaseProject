//
//  UITextField+JKInputLimit.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JKInputLimit)
@property (assign, nonatomic)  NSInteger bp_maxLength;//if <=0, no limit
@end
