//
//  NSDate+BPExtension.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/26.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSDate+BPExtension.h"

@implementation NSDate (BPExtension)

- (NSUInteger)bp_day {
    return [NSDate bp_day:self];
}

- (NSUInteger)bp_month {
    return [NSDate bp_month:self];
}

- (NSUInteger)bp_year {
    return [NSDate bp_year:self];
}

- (NSUInteger)bp_hour {
    return [NSDate bp_hour:self];
}

- (NSUInteger)bp_minute {
    return [NSDate bp_minute:self];
}

- (NSUInteger)bp_second {
    return [NSDate bp_second:self];
}

+ (NSUInteger)bp_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)bp_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)bp_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)bp_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)bp_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)bp_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)bp_daysInYear {
    return [NSDate bp_daysInYear:self];
}

+ (NSUInteger)bp_daysInYear:(NSDate *)date {
    return [self bp_isLeapYear:date] ? 366 : 365;
}

- (BOOL)bp_isLeapYear {
    return [NSDate bp_isLeapYear:self];
}

+ (BOOL)bp_isLeapYear:(NSDate *)date {
    NSUInteger year = [date bp_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)bp_formatYMD {
    return [NSDate bp_formatYMD:self];
}

+ (NSString *)bp_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date bp_year],[date bp_month], [date bp_day]];
}

- (NSUInteger)bp_weebpOfMonth {
    return [NSDate bp_weebpOfMonth:self];
}

+ (NSUInteger)bp_weebpOfMonth:(NSDate *)date {
    return [[date bp_lastdayOfMonth] bp_weekOfYear] - [[date bp_begindayOfMonth] bp_weekOfYear] + 1;
}

- (NSUInteger)bp_weekOfYear {
    return [NSDate bp_weekOfYear:self];
}

+ (NSUInteger)bp_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date bp_year];
    
    NSDate *lastdate = [date bp_lastdayOfMonth];
    
    for (i = 1;[[lastdate bp_dateAfterDay:-7 * i] bp_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)bp_dateAfterDay:(NSUInteger)day {
    return [NSDate bp_dateAfterDate:self day:day];
}

+ (NSDate *)bp_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)bp_dateAfterMonth:(NSUInteger)month {
    return [NSDate bp_dateAfterDate:self month:month];
}

+ (NSDate *)bp_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)bp_begindayOfMonth {
    return [NSDate bp_begindayOfMonth:self];
}

+ (NSDate *)bp_begindayOfMonth:(NSDate *)date {
    return [self bp_dateAfterDate:date day:-[date bp_day] + 1];
}

- (NSDate *)bp_lastdayOfMonth {
    return [NSDate bp_lastdayOfMonth:self];
}

+ (NSDate *)bp_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self bp_begindayOfMonth:date];
    return [[lastDate bp_dateAfterMonth:1] bp_dateAfterDay:-1];
}

- (NSUInteger)bp_daysAgo {
    return [NSDate bp_daysAgo:self];
}

+ (NSUInteger)bp_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)bp_weekday {
    return [NSDate bp_weekday:self];
}

+ (NSInteger)bp_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)bp_dayFromWeekday {
    return [NSDate bp_dayFromWeekday:self];
}

+ (NSString *)bp_dayFromWeekday:(NSDate *)date {
    switch([date bp_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)bp_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)bp_isToday {
    return [self bp_isSameDay:[NSDate date]];
}

- (NSDate *)bp_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)bp_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)bp_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date bp_stringWithFormat:format];
}

- (NSString *)bp_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}
- (NSInteger)weekdayStringFromDate:(NSDate*)inputDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/SuZhou"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return theComponents.weekday - 1;
}

+ (NSDate *)bp_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)bp_daysInMonth:(NSUInteger)month {
    return [NSDate bp_daysInMonth:self month:month];
}

+ (NSUInteger)bp_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date bp_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)bp_daysInMonth {
    return [NSDate bp_daysInMonth:self];
}

+ (NSUInteger)bp_daysInMonth:(NSDate *)date {
    return [self bp_daysInMonth:date month:[date bp_month]];
}

- (NSString *)bp_timeInfo {
    return [NSDate bp_timeInfoWithDate:self];
}

+ (NSString *)bp_timeInfoWithDate:(NSDate *)date {
    return [self bp_timeInfoWithDateString:[self bp_stringWithDate:date format:[self bp_ymdHmsFormat]]];
}

+ (NSString *)bp_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self bp_dateWithString:dateString format:[self bp_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate bp_month] - [date bp_month]);
    int year = (int)([curDate bp_year] - [date bp_year]);
    int day = (int)([curDate bp_day] - [date bp_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate bp_month] == 1 && [date bp_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self bp_daysInMonth:date month:[date bp_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate bp_day] + (totalDays - (int)[date bp_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate bp_month];
            int preMonth = (int)[date bp_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)bp_ymdFormat {
    return [NSDate bp_ymdFormat];
}

- (NSString *)bp_hmsFormat {
    return [NSDate bp_hmsFormat];
}

- (NSString *)bp_ymdHmsFormat {
    return [NSDate bp_ymdHmsFormat];
}

+ (NSString *)bp_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)bp_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)bp_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self bp_ymdFormat], [self bp_hmsFormat]];
}

- (NSDate *)bp_offsetYears:(int)numYears {
    return [NSDate bp_offsetYears:numYears fromDate:self];
}

+ (NSDate *)bp_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)bp_offsetMonths:(int)numMonths {
    return [NSDate bp_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)bp_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)bp_offsetDays:(int)numDays {
    return [NSDate bp_offsetDays:numDays fromDate:self];
}

+ (NSDate *)bp_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)bp_offsetHours:(int)hours {
    return [NSDate bp_offsetHours:hours fromDate:self];
}

+ (NSDate *)bp_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

@end

