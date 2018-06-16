//
//  NSDate+BPLunarCalendar.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>
///农历大写日期
@interface NSDate (BPLunarCalendar)
+ (NSCalendar *)_chineseCalendar;
//例如 五月初一
+ (NSString *)_currentMDDateString;
//例如 乙未年五月初一
+ (NSString *)_currentYMDDateString;
//例如 星期一
+ (NSString *)_currentWeek:(NSDate*)date;
//例如 星期一
+ (NSString *)_currentWeekWithDateString:(NSString *)datestring;
//例如 五月一
+ (NSString *)_currentCapitalDateString;
@end
