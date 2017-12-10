//
//  NSDate+BPAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "NSDate+BPAdd.h"

BPSYNTH_DUMMY_CLASS(NSDate_BPAdd)

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (BPAdd)

+ (NSCalendar *)bp_currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

- (NSDate *)startDate{
    NSDateComponents *components = [[NSDate bp_currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate bp_currentCalendar] dateFromComponents:components];
}

- (NSDate *)endDate{
    NSDateComponents *components = [[NSDate bp_currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [[NSDate bp_currentCalendar] dateFromComponents:components];
}

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
    NSDate *added = [self bp_dateByAddingDays:1];
    return [added isToday];
}

- (BOOL)isTomorrow{
    return [self bp_isEqualToDateIgnoringTime:[NSDate bp_dateTomorrow]];
}

- (BOOL)isThisWeek{
    return [self bp_isSameWeekAsDate:[NSDate date]];
    
}

- (BOOL)isNextWeek{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self bp_isSameWeekAsDate:newDate];
    
}

- (BOOL)isLastWeek{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self bp_isSameWeekAsDate:newDate];
    
}

- (BOOL)isThisMonth{
    return [self bp_isSameMonthAsDate:[NSDate date]];
    
}

- (BOOL)isNextMonth{
    return [self bp_isSameMonthAsDate:[[NSDate date] bp_dateByAddingMonths:1]];
    
}

- (BOOL)isLastMonth{
    return [self bp_isSameMonthAsDate:[[NSDate date] bp_dateBySubtractingMonths:1]];
    
}

- (BOOL)isThisYear{
    return [self bp_isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear{
    NSDateComponents *components1 = [[NSDate bp_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate bp_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (components1.year == (components2.year + 1));
    
}

- (BOOL)isLastYear{
    NSDateComponents *components1 = [[NSDate bp_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate bp_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (components1.year == (components2.year - 1));
}

- (BOOL)isInFuture{
    return ([self bp_isLaterThanDate:[NSDate date]]);
}

-(BOOL)isInPast{
    return ([self bp_isEarlierThanDate:[NSDate date]]);
}

- (BOOL)isWorkday{
    NSDateComponents *components = [[NSDate bp_currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)isWeekend{
    return !self.isWorkday;
}

- (BOOL)bp_isEqualToDateIgnoringTime: (NSDate *) aDate{
    NSDateComponents *components1 = [[NSDate bp_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate bp_currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)bp_isSameWeekAsDate: (NSDate *) aDate{
    NSDateComponents *components1 = [[NSDate bp_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate bp_currentCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfMonth != components2.weekOfMonth) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)bp_isSameMonthAsDate: (NSDate *) aDate{
    NSDateComponents *components1 = [[NSDate bp_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate bp_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)bp_isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate bp_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate bp_currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)bp_isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)bp_isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (NSDate *)bp_dateByAddingYears:(NSInteger)dYears {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)bp_dateBySubtractingYears: (NSInteger) dYears {
    return [self bp_dateByAddingYears:-dYears];
}

- (NSDate *)bp_dateByAddingMonths: (NSInteger) dMonths {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)bp_dateBySubtractingMonths: (NSInteger) dMonths {
    return [self bp_dateByAddingMonths:-dMonths];
}

- (NSDate *)bp_dateByAddingDays: (NSInteger) dDays {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)bp_dateBySubtractingDays: (NSInteger) dDays {
    return [self bp_dateByAddingDays: (dDays * -1)];
	
}

- (NSDate *)bp_dateByAddingHours: (NSInteger) dHours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
	
}

- (NSDate *)bp_dateBySubtractingHours: (NSInteger) dHours {
    return [self bp_dateByAddingHours: (dHours * -1)];
}

- (NSDate *)bp_dateByAddingMinutes: (NSInteger) dMinutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)bp_dateBySubtractingMinutes: (NSInteger) dMinutes {
    return [self bp_dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *)bp_dateAtStartOfDay {
    NSDateComponents *components = [[NSDate bp_currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate bp_currentCalendar] dateFromComponents:components];
}

- (NSDate *)bp_dateAtEndOfDay {
    NSDateComponents *components = [[NSDate bp_currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate bp_currentCalendar] dateFromComponents:components];
}

- (NSInteger)bp_minutesAfterDate: (NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)bp_minutesBeforeDate: (NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)bp_hoursAfterDate: (NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)bp_hoursBeforeDate: (NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)bp_daysAfterDate: (NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)bp_daysBeforeDate: (NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)bp_distanceInDaysToDate:(NSDate *)anotherDate {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

+ (NSDate *)bp_dateWithDaysFromNow: (NSInteger) days {
    return [[NSDate date] bp_dateByAddingDays:days];
}

+ (NSDate *)bp_dateWithDaysBeforeNow: (NSInteger) days {
    return [[NSDate date] bp_dateBySubtractingDays:days];
}

+ (NSDate *)bp_dateWithHoursFromNow: (NSInteger) dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)bp_dateWithHoursBeforeNow: (NSInteger) dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)bp_dateWithMinutesFromNow: (NSInteger) dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)bp_dateWithMinutesBeforeNow: (NSInteger) dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)bp_dateTomorrow {
    return [NSDate bp_dateWithDaysFromNow:1];
}

+ (NSDate *)bp_dateYesterday {
    return [NSDate bp_dateWithDaysBeforeNow:1];
}

- (NSString *)bp_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSString *)bp_stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter stringFromDate:self];
	
}

+ (NSDate *)bp_dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
	
}

+ (NSDate *)bp_dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter dateFromString:dateString];
	
}

+ (NSDate *)bp_dateWithTimestamp:(NSString *)timestamp {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSDate *date = [confromTimesp dateByAddingTimeInterval:480 * 60];
    return date;
	
}

+ (BOOL)bp_checkSystemTimeFormatterIs12HourType {
    static BOOL flag = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
        NSRange containsA = [formatStringForHours rangeOfString:@"a"];
        flag = containsA.location != NSNotFound;
        
    });
    return flag;
}


@end
