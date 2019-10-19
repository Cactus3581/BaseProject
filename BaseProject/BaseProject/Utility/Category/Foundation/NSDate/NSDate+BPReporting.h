//
// NSDate+Reporting.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (BPReporting)

// Return a date with a specified year, month and day.
+ (NSDate *)_dateWithYear:(int)year month:(int)month day:(int)day;

// Return midnight on the specified date.
+ (NSDate *)_midnightOfDate:(NSDate *)date;

// Return midnight today.
+ (NSDate *)_midnightToday;

// Return midnight tomorrow.
+ (NSDate *)_midnightTomorrow;

// Returns a date that is exactly 1 day after the specified date. Does *not*
// zero out the time components. For example, if the specified date is
// April 15 2012 10:00 AM, the return value will be April 16 2012 10:00 AM.
+ (NSDate *)_oneDayAfter:(NSDate *)date;

// Returns midnight of the first day of the current, previous or next Month.
// Note: firstDayOfNextMonth returns midnight of the first day of next month,
// which is effectively the same as the "last moment" of the current month.
+ (NSDate *)_firstDayOfCurrentMonth;
+ (NSDate *)_firstDayOfPreviousMonth;
+ (NSDate *)_firstDayOfNextMonth;

// Returns midnight of the first day of the current, previous or next Quarter.
// Note: firstDayOfNextQuarter returns midnight of the first day of next quarter,
// which is effectively the same as the "last moment" of the current quarter.
+ (NSDate *)_firstDayOfCurrentQuarter;
+ (NSDate *)_firstDayOfPreviousQuarter;
+ (NSDate *)_firstDayOfNextQuarter;

// Returns midnight of the first day of the current, previous or next Year.
// Note: firstDayOfNextYear returns midnight of the first day of next year,
// which is effectively the same as the "last moment" of the current year.
+ (NSDate *)_firstDayOfCurrentYear;
+ (NSDate *)_firstDayOfPreviousYear;
+ (NSDate *)_firstDayOfNextYear;


- (NSDate *)_dateFloor;
- (NSDate *)_dateCeil;

- (NSDate *)_startOfWeek;
- (NSDate *)_endOfWeek;

- (NSDate *)_startOfMonth;
- (NSDate *)_endOfMonth;

- (NSDate *)_startOfYear;
- (NSDate *)_endOfYear;

- (NSDate *)_previousDay;
- (NSDate *)_nextDay;

- (NSDate *)_previousWeek;
- (NSDate *)_nextWeek;

- (NSDate *)_previousMonth;
- (NSDate *)_previousMonth:(NSUInteger) monthsToMove;
- (NSDate *)_nextMonth;
- (NSDate *)_nextMonth:(NSUInteger) monthsToMove;

#ifdef DEBUG
// For testing only. A helper function to format and display a date
// with an optional comment. For example:
//     NSDate *test = [NSDate firstDayOfCurrentMonth];
//     [test logWithComment:@"First day of current month: "];
- (void)_logWithComment:(NSString *)comment;
#endif

@end
