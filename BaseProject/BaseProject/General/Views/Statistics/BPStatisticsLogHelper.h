//
//  BPStatisticsLogHelper.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/8/2.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kBugLog;

@interface BPStatisticsLogHelper : NSObject

// 日志展示
+ (void)setLogEvent:(NSString *)event;

// 埋点日志展示
+ (void)setLogEvent:(NSString *)event data:(NSDictionary *)dict;

@end
