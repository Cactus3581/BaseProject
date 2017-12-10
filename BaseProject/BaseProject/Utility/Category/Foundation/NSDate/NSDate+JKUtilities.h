//
//  NSDate+Utilities.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
// https://github.com/erica/NSDate-Extensions
#import <Foundation/Foundation.h>
#define BP_D_MINUTE	60
#define BP_D_HOUR	3600
#define BP_D_DAY	86400
#define BP_D_WEEK	604800
#define BP_D_YEAR	31556926
@interface NSDate (JKUtilities)
+ (NSCalendar *)_currentCalendar; // avoid bottlenecks
#pragma mark ---- Decomposing dates 分解的日期
@property (readonly) NSInteger _nearestHour;
@property (readonly) NSInteger _hour;
@property (readonly) NSInteger _minute;
@property (readonly) NSInteger _seconds;
@property (readonly) NSInteger _day;
@property (readonly) NSInteger _month;
@property (readonly) NSInteger _week;
@property (readonly) NSInteger _weekday;
@property (readonly) NSInteger _nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger _year;

#pragma mark ----short time 格式化的时间
@property (nonatomic, readonly) NSString *_shortString;
@property (nonatomic, readonly) NSString *_shortDateString;
@property (nonatomic, readonly) NSString *_shortTimeString;
@property (nonatomic, readonly) NSString *_mediumString;
@property (nonatomic, readonly) NSString *_mediumDateString;
@property (nonatomic, readonly) NSString *_mediumTimeString;
@property (nonatomic, readonly) NSString *_longString;
@property (nonatomic, readonly) NSString *_longDateString;
@property (nonatomic, readonly) NSString *_longTimeString;

///使用dateStyle timeStyle格式化时间
- (NSString *)_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
///给定format格式化时间
- (NSString *)_stringWithFormat:(NSString *)format;

#pragma mark ---- 从当前日期相对日期时间
///明天
+ (NSDate *)_dateTomorrow;
///昨天
+ (NSDate *)_dateYesterday;
///今天后几天
+ (NSDate *)_dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)_dateWithDaysBeforeNow:(NSInteger)days;
///当前小时后dHours个小时
+ (NSDate *)_dateWithHoursFromNow:(NSInteger)dHours;
///当前小时前dHours个小时
+ (NSDate *)_dateWithHoursBeforeNow:(NSInteger)dHours;
///当前分钟后dMinutes个分钟
+ (NSDate *)_dateWithMinutesFromNow:(NSInteger)dMinutes;
///当前分钟前dMinutes个分钟
+ (NSDate *)_dateWithMinutesBeforeNow:(NSInteger)dMinutes;


#pragma mark ---- Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)_isEqualToDateIgnoringTime:(NSDate *)aDate;
///是否是今天
- (BOOL)_isToday;
///是否是明天
- (BOOL)_isTomorrow;
///是否是昨天
- (BOOL)_isYesterday;

///是否是同一周
- (BOOL)_isSameWeekAsDate:(NSDate *)aDate;
///是否是本周
- (BOOL)_isThisWeek;
///是否是本周的下周
- (BOOL)_isNextWeek;
///是否是本周的上周
- (BOOL)_isLastWeek;

///是否是同一月
- (BOOL)_isSameMonthAsDate:(NSDate *)aDate;
///是否是本月
- (BOOL)_isThisMonth;
///是否是本月的下月
- (BOOL)_isNextMonth;
///是否是本月的上月
- (BOOL)_isLastMonth;

///是否是同一年
- (BOOL)_isSameYearAsDate:(NSDate *)aDate;
///是否是今年
- (BOOL)_isThisYear;
///是否是今年的下一年
- (BOOL)_isNextYear;
///是否是今年的上一年
- (BOOL)_isLastYear;

///是否提前aDate
- (BOOL)_isEarlierThanDate:(NSDate *)aDate;
///是否晚于aDate
- (BOOL)_isLaterThanDate:(NSDate *)aDate;
///是否晚是未来
- (BOOL)_isInFuture;
///是否晚是过去
- (BOOL)_isInPast;


///是否是工作日
- (BOOL)_isTypicallyWorkday;
///是否是周末
- (BOOL)_isTypicallyWeekend;

#pragma mark ---- Adjusting dates 调节时间
///增加dYears年
- (NSDate *)_dateByAddingYears:(NSInteger)dYears;
///减少dYears年
- (NSDate *)_dateBySubtractingYears:(NSInteger)dYears;
///增加dMonths月
- (NSDate *)_dateByAddingMonths:(NSInteger)dMonths;
///减少dMonths月
- (NSDate *)_dateBySubtractingMonths:(NSInteger)dMonths;
///增加dDays天
- (NSDate *)_dateByAddingDays:(NSInteger)dDays;
///减少dDays天
- (NSDate *)_dateBySubtractingDays:(NSInteger)dDays;
///增加dHours小时
- (NSDate *)_dateByAddingHours:(NSInteger)dHours;
///减少dHours小时
- (NSDate *)_dateBySubtractingHours:(NSInteger)dHours;
///增加dMinutes分钟
- (NSDate *)_dateByAddingMinutes:(NSInteger)dMinutes;
///减少dMinutes分钟
- (NSDate *)_dateBySubtractingMinutes:(NSInteger)dMinutes;


#pragma mark ---- 时间间隔
///比aDate晚多少分钟
- (NSInteger)_minutesAfterDate:(NSDate *)aDate;
///比aDate早多少分钟
- (NSInteger)_minutesBeforeDate:(NSDate *)aDate;
///比aDate晚多少小时
- (NSInteger)_hoursAfterDate:(NSDate *)aDate;
///比aDate早多少小时
- (NSInteger)_hoursBeforeDate:(NSDate *)aDate;
///比aDate晚多少天
- (NSInteger)_daysAfterDate:(NSDate *)aDate;
///比aDate早多少天
- (NSInteger)_daysBeforeDate:(NSDate *)aDate;

///与anotherDate间隔几天
- (NSInteger)_distanceDaysToDate:(NSDate *)anotherDate;
///与anotherDate间隔几月
- (NSInteger)_distanceMonthsToDate:(NSDate *)anotherDate;
///与anotherDate间隔几年
- (NSInteger)_distanceYearsToDate:(NSDate *)anotherDate;
@end
