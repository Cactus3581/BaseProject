//
//  BPCalendar.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPPlanCalendarModel.h"

@class BPCalendarModel;

@interface BPCalendar : NSObject

@property (nonatomic,strong,readonly) BPCalendarModel *model; //日期对象
@property (nonatomic,assign,readonly) NSInteger calendarViewRows; //日历对象有几行
@property (nonatomic,assign,readonly) CGFloat  calendarViewHeight;//日历对象的高度

@property (nonatomic,assign) CGFloat  yearMonthHeight;//年月高度。默认50.0f
@property (nonatomic,assign) CGFloat  weekHight;//星期高度。默认40.0f
@property (nonatomic,assign) CGFloat  dayHight;//单个日期日高度。默认60.0f

@property (nonatomic,assign) BOOL  show_ymView;//是否显示 。默认显示
@property (nonatomic,assign) BOOL  show_weekView;//是否显示。默认显示

+ (instancetype)calendarWithModel:(BPPlanCalendarDateModel *)model;//初始化

- (void)configCalendarWithSussess:(dispatch_block_t)success fail:(dispatch_block_t)fail;//异步处理数据

- (BOOL)configCalendar; //同步处理数据

@end
