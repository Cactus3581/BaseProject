//
//  NSDateFormatter+Make.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "NSDateFormatter+BPMake.h"

@implementation NSDateFormatter (BPMake)

+(NSDateFormatter *)_dateFormatterWithFormat:(NSString *)format {
    return [self _dateFormatterWithFormat:format timeZone:nil];
}

+(NSDateFormatter *)_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone {
    return [self _dateFormatterWithFormat:format timeZone:timeZone locale:nil];
}

+(NSDateFormatter *)_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    if (format == nil || [format isEqualToString:@""]) return nil;
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-tz-%@-fmt-%@-loc-%@", [timeZone abbreviation], format, [locale localeIdentifier]];
    NSMutableDictionary* dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter* dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (locale != nil) [dateFormatter setLocale:locale]; // this may change so don't cache
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone]; // this may change
    return dateFormatter;
}

+(NSDateFormatter *)_dateFormatterWithDateStyle:(NSDateFormatterStyle)style {
    return [self _dateFormatterWithDateStyle:style timeZone:nil];
}

+(NSDateFormatter *)_dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone {
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-%@-dateStyle-%d", [timeZone abbreviation], (int)style];
    NSMutableDictionary* dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter* dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:style];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone]; // this may change so don't cache
    return dateFormatter;
}

+(NSDateFormatter *)_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style {
    return [self _dateFormatterWithTimeStyle:style timeZone:nil];
}

+(NSDateFormatter *)_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone {
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-%@-timeStyle-%d", [timeZone abbreviation], (int)style];
    NSMutableDictionary* dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter* dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:style];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone]; // this may change so don't cache
    return dateFormatter;
}

@end
