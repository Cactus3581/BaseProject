//
//  NSDate+Formatter.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JKFormatter)

+(NSDateFormatter *)jk_formatter;
+(NSDateFormatter *)jk_formatterWithoutTime;
+(NSDateFormatter *)jk_formatterWithoutDate;

-(NSString *)jk_formatWithUTCTimeZone;
-(NSString *)jk_formatWithLocalTimeZone;
-(NSString *)jk_formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)jk_formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)jk_formatWithUTCTimeZoneWithoutTime;
-(NSString *)jk_formatWithLocalTimeZoneWithoutTime;
-(NSString *)jk_formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)jk_formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)jk_formatWithUTCWithoutDate;
-(NSString *)jk_formatWithLocalTimeWithoutDate;
-(NSString *)jk_formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)jk_formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)jk_currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)jk_dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)jk_dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)jk_dateWithFormat:(NSString *)format;
@end
