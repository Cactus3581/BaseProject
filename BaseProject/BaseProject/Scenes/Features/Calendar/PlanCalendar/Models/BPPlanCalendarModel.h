//
//  BPPlanCalendarModel.h
//  BaseProject
//
//  Created by Ryan on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPPlanCalendarModel : NSObject
@property (nonatomic,copy) NSString *remindTime;// 每日提醒时间
@property (nonatomic,strong) NSArray *planInfo; //课程视频列表
@property (nonatomic,strong) NSArray *generalEventArray;// 其他数据
@property (nonatomic,strong) NSArray *quitPlanArray;//退出计划
@end

/**
 详细日期集合
 */
@interface BPPlanCalendarDateModel : NSObject
@property (nonatomic,copy) NSString *plan_date;//日期
@property (nonatomic,strong) NSArray *plan_days;//详细日期集合
@end

/**
 详细日期
 */
@interface BPPlanCalendarDayModel : NSObject
@property (nonatomic,assign) BOOL is_res;//是否休息
@property (nonatomic,assign) BOOL is_finish;//是否完成
@property (nonatomic,assign) BOOL is_sign;//是否打卡
@property (nonatomic,copy) NSString *plan_day;//日期
@end

/**
 其他数据
 */
@interface BPPlanCalendarGeneralModel : NSObject
@property (nonatomic,assign) BOOL is_showArrow;//是否显示箭头
@property (nonatomic,assign) BOOL is_showTime;//是否显示提醒时间
@property (nonatomic,copy) NSString *title;//
@property (nonatomic,copy) NSString *time;//提醒时间
@property (nonatomic,copy) NSString *fileName;//
@end

