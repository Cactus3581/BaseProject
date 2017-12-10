//
//  NSDate+Extension.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSDate (JKExtension)


/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)_day;
- (NSUInteger)_month;
- (NSUInteger)_year;
- (NSUInteger)_hour;
- (NSUInteger)_minute;
- (NSUInteger)_second;
+ (NSUInteger)_day:(NSDate *)date;
+ (NSUInteger)_month:(NSDate *)date;
+ (NSUInteger)_year:(NSDate *)date;
+ (NSUInteger)_hour:(NSDate *)date;
+ (NSUInteger)_minute:(NSDate *)date;
+ (NSUInteger)_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)_daysInYear;
+ (NSUInteger)_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)_isLeapYear;
+ (BOOL)_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)_weekOfYear;
+ (NSUInteger)_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)_formatYMD;
+ (NSString *)_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)_weeksOfMonth;
+ (NSUInteger)_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)_begindayOfMonth;
+ (NSDate *)_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)_lastdayOfMonth;
+ (NSDate *)_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)_dateAfterDay:(NSUInteger)day;
+ (NSDate *)_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)_offsetYears:(int)numYears;
+ (NSDate *)_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)_offsetMonths:(int)numMonths;
+ (NSDate *)_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)_offsetDays:(int)numDays;
+ (NSDate *)_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)_offsetHours:(int)hours;
+ (NSDate *)_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)_daysAgo;
+ (NSUInteger)_daysAgo:(NSDate *)date;

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
- (NSInteger)_weekday;
+ (NSInteger)_weekday:(NSDate *)date;

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
- (NSString *)_dayFromWeekday;
+ (NSString *)_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)_dateByAddingDays:(NSUInteger)days;

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
+ (NSString *)_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)_stringWithFormat:(NSString *)format;
+ (NSDate *)_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)_daysInMonth:(NSUInteger)month;
+ (NSUInteger)_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)_daysInMonth;
+ (NSUInteger)_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)_timeInfo;
+ (NSString *)_timeInfoWithDate:(NSDate *)date;
+ (NSString *)_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)_ymdFormat;
- (NSString *)_hmsFormat;
- (NSString *)_ymdHmsFormat;
+ (NSString *)_ymdFormat;
+ (NSString *)_hmsFormat;
+ (NSString *)_ymdHmsFormat;

@end
