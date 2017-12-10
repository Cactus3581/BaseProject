//
//  NSDateFormatter+Make.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (JKMake)
+(NSDateFormatter *)jk_dateFormatterWithFormat:(NSString *)format;
+(NSDateFormatter *)jk_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)jk_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
+(NSDateFormatter *)jk_dateFormatterWithDateStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)jk_dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)jk_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)jk_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
@end
