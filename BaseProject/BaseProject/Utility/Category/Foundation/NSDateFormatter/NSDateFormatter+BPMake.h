//
//  NSDateFormatter+Make.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (BPMake)
+(NSDateFormatter *)_dateFormatterWithFormat:(NSString *)format;
+(NSDateFormatter *)_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
+(NSDateFormatter *)_dateFormatterWithDateStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)_dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
@end
