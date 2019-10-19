//
//  BPPlanCalendarModel.m
//  BaseProject
//
//  Created by Ryan on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPPlanCalendarModel.h"

@implementation BPPlanCalendarModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
//             @"planInfo":[BPPlanCalendarDayModel class],
             @"planInfo":[BPPlanCalendarDateModel class],
             @"generalEventArray":[BPPlanCalendarGeneralModel class],
             @"quitPlanArray":[BPPlanCalendarGeneralModel class],
             };
}

@end

@implementation BPPlanCalendarDayModel

@end

@implementation BPPlanCalendarGeneralModel

@end

@implementation BPPlanCalendarDateModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"plan_days":[BPPlanCalendarDayModel class],
             };
}

@end
