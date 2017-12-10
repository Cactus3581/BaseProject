//
//  NSDate+BPZeroDate.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSDate (BPZeroDate)
+ (NSDate *)_zeroTodayDate;
+ (NSDate *)_zero24TodayDate;

- (NSDate *)_zeroDate;
- (NSDate *)_zero24Date;
@end
