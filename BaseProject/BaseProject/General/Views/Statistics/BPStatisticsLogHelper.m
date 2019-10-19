//
//  BPStatisticsLogHelper.m
//  BaseProject
//
//  Created by Ryan on 2018/8/2.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPStatisticsLogHelper.h"
#import "BPAppDelegate.h"

@interface BPStatisticsLogHelper()
@end

@implementation BPStatisticsLogHelper

// 埋点日志展示
+ (void)setLogEvent:(NSString *)event data:(NSDictionary *)dict {
    NSData *data = [NSJSONSerialization dataWithJSONObject:BPValidateDict(dict) options:NSJSONWritingPrettyPrinted error:nil];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *logText = [NSString stringWithFormat:@"Event：%@\nData：%@",BPValidateString(event),text];
    [self setLogEvent:logText];
}

// 日志展示
+ (void)setLogEvent:(NSString *)event {
    BPAppDelegate *delegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.logView setLogText:event];
}

@end
