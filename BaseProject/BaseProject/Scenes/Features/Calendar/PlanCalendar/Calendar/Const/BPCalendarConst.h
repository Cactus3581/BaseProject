//
//  BPCalendarConst.h
//  BaseProject
//
//  Created by Ryan on 2017/11/29.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

//日期标记模式
typedef NS_OPTIONS(NSUInteger, BPPlanCalendarDayMode) {
    PlanCalendarDayNone,//无标记
    PlanCalendarDayRes = 1 << 0,//是否休息
    PlanCalendarDayFinish = 1 << 1,//是否完成
    PlanCalendarDaySign = 1 << 2,//是否打卡
    PlanCalendarDayCurrentDay = 1 << 3 //是否今天
};

//四个任务，完成一项，为1颗星，完成两个任务，或者三个任务为两颗星，完成四个任务为三颗星
//typedef NS_OPTIONS(NSUInteger, BPPlanCalendarDayEnentMode) {
//    PlanCalendarDayNone,//无标记
//    PlanCalendarDayListen = 1 << 0,//是否听
//    PlanCalendarDaySay = 1 << 1,//是否说
//    PlanCalendarDayRead = 1 << 2,//是否读
//    PlanCalendarDayWrite = 1 << 3,//是否写
//    PlanCalendarDayCurrentDay = 1 << 4 //是否今天
//};

UIKIT_EXTERN  NSInteger  const BPCalenarWeeBPeven;
UIKIT_EXTERN  CGFloat  const BPCalenarWeekHeight;
UIKIT_EXTERN  CGFloat  const BPCalenarYearHeight;
UIKIT_EXTERN  CGFloat  const BPCalenarDayHeight;

@interface BPCalendarConst : NSObject

@end
