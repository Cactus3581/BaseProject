//
//  BPCalendarDataSource.h
//  BaseProject
//
//  Created by Ryan on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPPlanCalendarModel.h"

@class BPCalendarModel;

@interface BPCalendarDataSource : NSObject

+ (instancetype)calendarDataSourceWithDate:(NSDate *)date calendarModel:(BPPlanCalendarDateModel *)model;

- (BPCalendarModel *)handleData;

@end
