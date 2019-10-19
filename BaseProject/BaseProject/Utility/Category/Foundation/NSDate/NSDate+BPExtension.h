//
//  NSDate+BPExtension.h
//  BaseProject
//
//  Created by Ryan on 2017/11/26.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BPExtension)
- (NSInteger)weekdayStringFromDate:(NSDate*)inputDate;

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)bp_day;
- (NSUInteger)bp_month;
- (NSUInteger)bp_year;
- (NSUInteger)bp_hour;
- (NSUInteger)bp_minute;
- (NSUInteger)bp_second;
+ (NSUInteger)bp_day:(NSDate *)date;
+ (NSUInteger)bp_month:(NSDate *)date;
+ (NSUInteger)bp_year:(NSDate *)date;
+ (NSUInteger)bp_hour:(NSDate *)date;
+ (NSUInteger)bp_minute:(NSDate *)date;
+ (NSUInteger)bp_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)bp_daysInYear;
+ (NSUInteger)bp_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)bp_isLeapYear;
+ (BOOL)bp_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)bp_weekOfYear;
+ (NSUInteger)bp_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)bp_formatYMD;
+ (NSString *)bp_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)bp_weebpOfMonth;
+ (NSUInteger)bp_weebpOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)bp_begindayOfMonth;
+ (NSDate *)bp_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)bp_lastdayOfMonth;
+ (NSDate *)bp_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)bp_dateAfterDay:(NSUInteger)day;
+ (NSDate *)bp_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)bp_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)bp_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)bp_offsetYears:(int)numYears;
+ (NSDate *)bp_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)bp_offsetMonths:(int)numMonths;
+ (NSDate *)bp_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)bp_offsetDays:(int)numDays;
+ (NSDate *)bp_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)bp_offsetHours:(int)hours;
+ (NSDate *)bp_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)bp_daysAgo;
+ (NSUInteger)bp_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)bp_weekday;
+ (NSInteger)bp_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)bp_dayFromWeekday;
+ (NSString *)bp_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)bp_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)bp_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)bp_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)bp_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)bp_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)bp_stringWithFormat:(NSString *)format;
+ (NSDate *)bp_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)bp_daysInMonth:(NSUInteger)month;
+ (NSUInteger)bp_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)bp_daysInMonth;
+ (NSUInteger)bp_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)bp_timeInfo;
+ (NSString *)bp_timeInfoWithDate:(NSDate *)date;
+ (NSString *)bp_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)bp_ymdFormat;
- (NSString *)bp_hmsFormat;
- (NSString *)bp_ymdHmsFormat;

+ (NSString *)bp_ymdFormat;
+ (NSString *)bp_hmsFormat;
+ (NSString *)bp_ymdHmsFormat;

@end
