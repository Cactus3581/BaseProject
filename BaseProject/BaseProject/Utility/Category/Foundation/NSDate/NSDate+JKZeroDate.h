//
//  NSDate+JKZeroDate.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSDate (JKZeroDate)
+ (NSDate *)jk_zeroTodayDate;
+ (NSDate *)jk_zero24TodayDate;

- (NSDate *)jk_zeroDate;
- (NSDate *)jk_zero24Date;
@end
