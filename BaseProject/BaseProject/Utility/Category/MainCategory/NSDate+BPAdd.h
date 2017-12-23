//
//  NSDate+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 16/5/13.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (BPAdd)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - fast property

@property (nonatomic, readonly) NSDate *startDate;
@property (nonatomic, readonly) NSDate *endDate;
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger nanosecond;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;
@property (nonatomic, readonly) BOOL isLeapMonth;
@property (nonatomic, readonly) BOOL isLeapYear;
@property (nonatomic, readonly) BOOL isToday;
@property (nonatomic, readonly) BOOL isTomorrow; 
@property (nonatomic, readonly) BOOL isThisWeek; 
@property (nonatomic, readonly) BOOL isNextWeek; 
@property (nonatomic, readonly) BOOL isLastWeek; 
@property (nonatomic, readonly) BOOL isThisMonth; 
@property (nonatomic, readonly) BOOL isNextMonth; 
@property (nonatomic, readonly) BOOL isLastMonth; 
@property (nonatomic, readonly) BOOL isThisYear; 
@property (nonatomic, readonly) BOOL isNextYear; 
@property (nonatomic, readonly) BOOL isLastYear; 
@property (nonatomic, readonly) BOOL isInFuture; 
@property (nonatomic, readonly) BOOL isInPast; 
@property (nonatomic, readonly) BOOL isWorkday;
@property (nonatomic, readonly) BOOL isWeekend;

#pragma mark - date Change(时间增减相关)

- (NSDate *)bp_dateByAddingYears: (NSInteger) dYears;
- (NSDate *)bp_dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *)bp_dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *)bp_dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *)bp_dateByAddingDays: (NSInteger) dDays;
- (NSDate *)bp_dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *)bp_dateByAddingHours: (NSInteger) dHours;
- (NSDate *)bp_dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *)bp_dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *)bp_dateBySubtractingMinutes: (NSInteger) dMinutes;
+ (NSDate *)bp_dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *)bp_dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *)bp_dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *)bp_dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *)bp_dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *)bp_dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *)bp_dateTomorrow;
+ (NSDate *)bp_dateYesterday;

#pragma mark - date intervals(获取时间间隔相关)

- (NSInteger)bp_minutesAfterDate: (NSDate *)aDate;
- (NSInteger)bp_minutesBeforeDate: (NSDate *)aDate;
- (NSInteger)bp_hoursAfterDate: (NSDate *)aDate;
- (NSInteger)bp_hoursBeforeDate: (NSDate *)aDate;
- (NSInteger)bp_daysAfterDate: (NSDate *)aDate;
- (NSInteger)bp_daysBeforeDate: (NSDate *)aDate;
- (NSInteger)bp_distanceInDaysToDate:(NSDate *)anotherDate;

#pragma mark - equal(时间比较相关)

- (BOOL)bp_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL)bp_isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL)bp_isSameMonthAsDate: (NSDate *) aDate;
- (BOOL)bp_isSameYearAsDate: (NSDate *) aDate;
- (BOOL)bp_isEarlierThanDate: (NSDate *) aDate;
- (BOOL)bp_isLaterThanDate: (NSDate *) aDate;

#pragma mark - date Format (时间格式相关)

- (NSString *)bp_stringWithFormat:(NSString *)format;

- (NSString *)bp_stringWithFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone
                                 locale:(NSLocale *)locale;

+ (NSDate *)bp_dateWithString:(NSString *)dateString format:(NSString *)format;

+ (NSDate *)bp_dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(NSTimeZone *)timeZone
                             locale:(NSLocale *)locale;

#pragma mark - timeStamp (时间戳相关)

+ (NSDate *)bp_dateWithTimestamp:(NSString *)timestamp;

#pragma mark - other

/**判断是否是12小时格式*/
+ (BOOL)bp_checkSystemTimeFormatterIs12HourType;

@end

NS_ASSUME_NONNULL_END
