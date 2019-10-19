//
//  NSDate+Formatter.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BPFormatter)

+ (NSDateFormatter *)_formatter;
+ (NSDateFormatter *)_formatterWithoutTime;
+ (NSDateFormatter *)_formatterWithoutDate;

- (NSString *)_formatWithUTCTimeZone;
- (NSString *)_formatWithLocalTimeZone;
- (NSString *)_formatWithTimeZoneOffset:(NSTimeInterval)offset;
- (NSString *)_formatWithTimeZone:(NSTimeZone *)timezone;

- (NSString *)_formatWithUTCTimeZoneWithoutTime;
- (NSString *)_formatWithLocalTimeZoneWithoutTime;
- (NSString *)_formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
- (NSString *)_formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

- (NSString *)_formatWithUTCWithoutDate;
- (NSString *)_formatWithLocalTimeWithoutDate;
- (NSString *)_formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
- (NSString *)_formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)_currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)_dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)_dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)_dateWithFormat:(NSString *)format;
@end
