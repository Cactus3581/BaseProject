//
//  NSDate+BPUtilities.h
//  BaseProject
//
//  Created by Ryan on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+BPUtilities.h"
#import "NSDate+BPExtension.h"

#define bp_D_MINUTE    60
#define bp_D_HOUR    3600
#define bp_D_DAY    86400
#define bp_D_WEEK    604800
#define bp_D_YEAR    31556926

@interface NSDate (BPUtilities)
+ (NSCalendar *)bp_currentCalendar; // avoid bottlenecbp
#pragma mark ---- Decomposing dates 分解的日期
@property (readonly) NSInteger bp_nearestHour;
@property (readonly) NSInteger bp_hour;
@property (readonly) NSInteger bp_minute;
@property (readonly) NSInteger bp_seconds;
@property (readonly) NSInteger bp_day;
@property (readonly) NSInteger bp_month;
@property (readonly) NSInteger bp_week;
@property (readonly) NSInteger bp_weekday;
@property (readonly) NSInteger bp_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger bp_year;

#pragma mark ----short time 格式化的时间
@property (nonatomic, readonly) NSString *bp_shortString;
@property (nonatomic, readonly) NSString *bp_shortDateString;
@property (nonatomic, readonly) NSString *bp_shortTimeString;
@property (nonatomic, readonly) NSString *bp_mediumString;
@property (nonatomic, readonly) NSString *bp_mediumDateString;
@property (nonatomic, readonly) NSString *bp_mediumTimeString;
@property (nonatomic, readonly) NSString *bp_longString;
@property (nonatomic, readonly) NSString *bp_longDateString;
@property (nonatomic, readonly) NSString *bp_longTimeString;

///使用dateStyle timeStyle格式化时间
- (NSString *)bp_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
///给定format格式化时间
- (NSString *)bp_stringWithFormat:(NSString *)format;

#pragma mark ---- 从当前日期相对日期时间
///明天
+ (NSDate *)bp_dateTomorrow;
///昨天
+ (NSDate *)bp_dateYesterday;
///今天后几天
+ (NSDate *)bp_dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)bp_dateWithDaysBeforeNow:(NSInteger)days;
///当前小时后dHours个小时
+ (NSDate *)bp_dateWithHoursFromNow:(NSInteger)dHours;
///当前小时前dHours个小时
+ (NSDate *)bp_dateWithHoursBeforeNow:(NSInteger)dHours;
///当前分钟后dMinutes个分钟
+ (NSDate *)bp_dateWithMinutesFromNow:(NSInteger)dMinutes;
///当前分钟前dMinutes个分钟
+ (NSDate *)bp_dateWithMinutesBeforeNow:(NSInteger)dMinutes;


#pragma mark ---- Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)bp_isEqualToDateIgnoringTime:(NSDate *)aDate;
///是否是今天
- (BOOL)bp_isToday;
///是否是明天
- (BOOL)bp_isTomorrow;
///是否是昨天
- (BOOL)bp_isYesterday;

///是否是同一周
- (BOOL)bp_isSameWeekAsDate:(NSDate *)aDate;
///是否是本周
- (BOOL)bp_isThisWeek;
///是否是本周的下周
- (BOOL)bp_isNextWeek;
///是否是本周的上周
- (BOOL)bp_isLastWeek;

///是否是同一月
- (BOOL)bp_isSameMonthAsDate:(NSDate *)aDate;
///是否是本月
- (BOOL)bp_isThisMonth;
///是否是本月的下月
- (BOOL)bp_isNextMonth;
///是否是本月的上月
- (BOOL)bp_isLastMonth;

///是否是同一年
- (BOOL)bp_isSameYearAsDate:(NSDate *)aDate;
///是否是今年
- (BOOL)bp_isThisYear;
///是否是今年的下一年
- (BOOL)bp_isNextYear;
///是否是今年的上一年
- (BOOL)bp_isLastYear;

///是否提前aDate
- (BOOL)bp_isEarlierThanDate:(NSDate *)aDate;
///是否晚于aDate
- (BOOL)bp_isLaterThanDate:(NSDate *)aDate;
///是否晚是未来
- (BOOL)bp_isInFuture;
///是否晚是过去
- (BOOL)bp_isInPast;


///是否是工作日
- (BOOL)bp_isTypicallyWorkday;
///是否是周末
- (BOOL)bp_isTypicallyWeekend;

#pragma mark ---- Adjusting dates 调节时间
///增加dYears年
- (NSDate *)bp_dateByAddingYears:(NSInteger)dYears;
///减少dYears年
- (NSDate *)bp_dateBySubtractingYears:(NSInteger)dYears;
///增加dMonths月
- (NSDate *)bp_dateByAddingMonths:(NSInteger)dMonths;
///减少dMonths月
- (NSDate *)bp_dateBySubtractingMonths:(NSInteger)dMonths;
///增加dDays天
- (NSDate *)bp_dateByAddingDays:(NSInteger)dDays;
///减少dDays天
- (NSDate *)bp_dateBySubtractingDays:(NSInteger)dDays;
///增加dHours小时
- (NSDate *)bp_dateByAddingHours:(NSInteger)dHours;
///减少dHours小时
- (NSDate *)bp_dateBySubtractingHours:(NSInteger)dHours;
///增加dMinutes分钟
- (NSDate *)bp_dateByAddingMinutes:(NSInteger)dMinutes;
///减少dMinutes分钟
- (NSDate *)bp_dateBySubtractingMinutes:(NSInteger)dMinutes;


#pragma mark ---- 时间间隔
///比aDate晚多少分钟
- (NSInteger)bp_minutesAfterDate:(NSDate *)aDate;
///比aDate早多少分钟
- (NSInteger)bp_minutesBeforeDate:(NSDate *)aDate;
///比aDate晚多少小时
- (NSInteger)bp_hoursAfterDate:(NSDate *)aDate;
///比aDate早多少小时
- (NSInteger)bp_hoursBeforeDate:(NSDate *)aDate;
///比aDate晚多少天
- (NSInteger)bp_daysAfterDate:(NSDate *)aDate;
///比aDate早多少天
- (NSInteger)bp_daysBeforeDate:(NSDate *)aDate;

///与anotherDate间隔几天
- (NSInteger)bp_distanceDaysToDate:(NSDate *)anotherDate;
///与anotherDate间隔几月
- (NSInteger)bp_distanceMonthsToDate:(NSDate *)anotherDate;
///与anotherDate间隔几年
- (NSInteger)bp_distanceYearsToDate:(NSDate *)anotherDate;

@end
