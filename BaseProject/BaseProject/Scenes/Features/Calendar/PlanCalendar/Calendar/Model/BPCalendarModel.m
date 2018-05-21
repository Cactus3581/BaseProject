//
//  BPCalendarModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendarModel.h"

@implementation BPCalendarModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"weekArray":[BPCalendarWeekModel class],
             @"dayArray":[BPCalendarDayModel class],
             };
}
@end


@implementation BPCalendarWeekModel

@end


@implementation BPCalendarDayModel

@end

