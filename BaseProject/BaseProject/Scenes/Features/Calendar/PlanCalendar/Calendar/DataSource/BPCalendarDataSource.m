//
//  BPCalendarDataSource.m
//  BaseProject
//
//  Created by Ryan on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendarDataSource.h"
#import "MJExtension.h"
#import "BPCalendarModel.h"
#import "NSDate+BPExtension.h"
#import "NSDate+BPUtilities.h"
#import "BPCalendarConst.h"

@interface BPCalendarDataSource()
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) BPPlanCalendarDateModel *model;
@end

@implementation BPCalendarDataSource

#pragma mark - init
+ (instancetype)calendarDataSourceWithDate:(NSDate *)date calendarModel:(BPPlanCalendarDateModel *)model {
    BPCalendarDataSource *dataSource = [[BPCalendarDataSource alloc] initWithDate:date calendarModel:model];
    return dataSource;
}

- (instancetype)initWithDate:(NSDate *)date calendarModel:(BPPlanCalendarDateModel *)model {
    self = [super init];
    if (self) {
        self.date = date;
        self.model = model;
    }
    return self;
}

- (BPCalendarModel *)handleData {
    BPCalendarModel *model = [self calendarDate];
    model.dayArray = [self dayArray];
    model.weekArray = [self weekArray];
    return model;
}

#pragma mark - 返回年月数据
- (BPCalendarModel *)calendarDate  {
    BPCalendarModel *model = [[BPCalendarModel alloc] init];
    NSInteger year = [self.date bp_year];
    NSInteger month = [self.date bp_month];

    model.year = [NSString stringWithFormat:@"%ld",(long)year];
    model.month = [NSString stringWithFormat:@"%ld",(long)month];
    model.date = [NSString stringWithFormat:@"%@-%@",model.year,model.month];
    return model;
}

#pragma mark - 返回日数据
- (NSArray *)dayArray {
    //self.date 指给我的日历对象的第一天
    
    //数据源
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *array_server = self.model.plan_days.mutableCopy;
    
    //前期日期处理：补位
    NSInteger weekDay = [self.date weekdayStringFromDate:self.date];//该日期是星期几,0代表星期天
    for (NSInteger i = 0; i < weekDay ; i++){
        BPCalendarDayModel *model = [[BPCalendarDayModel alloc] init];
        NSDate *front_day_date =  [self.date bp_dateAfterDay:-(weekDay-i)];
        NSInteger day = [front_day_date bp_day];
        model.title = [@(day) stringValue];
        model.date = [front_day_date bp_stringWithFormat:@"yyyy-MM-dd"];
        model.showTitle = NO;
        model.dayEventMarkMode = PlanCalendarDayNone;
        [array addObject:model];
    }
    
    //中期日期处理
    //TODO: 若中间有不连续的日期，需要插值补位
    for (BPPlanCalendarDayModel *model_server in array_server) {
        NSDate *day_date = [NSDate bp_dateWithString:model_server.plan_day format:@"yyyy-MM-dd"];
        NSInteger day = [day_date bp_day];
        BPCalendarDayModel *model = [[BPCalendarDayModel alloc] init];
        model.title = [@(day) stringValue];
        model.showTitle = YES;
        model.date = model_server.plan_day;
        
        BOOL is_res = model_server.is_res;
        BOOL is_finish = model_server.is_finish;
        BOOL is_sign = model_server.is_sign;
        BOOL is_today = [day_date bp_isToday];
        model.dayEventMarkMode = is_res << 0 | is_finish << 1 | is_sign << 2 | is_today << 3  ;
        [array addObject:model];
    }
    
    //后期日期处理：补位
    //TODO: 后期需要插值补位
    BPCalendarDayModel *lastObject = array.lastObject;
    NSDate *last_date = [NSDate bp_dateWithString:lastObject.date format:@"yyyy-MM-dd"];
    NSInteger last_weekDay = [last_date weekdayStringFromDate:last_date];//该日期是星期几
    for (int i = 0; i< BPCalenarWeeBPeven - last_weekDay - 1; i++) {
        BPCalendarDayModel *model = [[BPCalendarDayModel alloc] init];
        model.title = @"";
        model.dayEventMarkMode = PlanCalendarDayNone;
        model.showTitle = NO;
        [array addObject:model];
    }
    return array.copy;
}

#pragma mark - 返回周数据
- (NSArray *)weekArray {
    NSArray *array = [self handleWeekData];
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        BPCalendarWeekModel *model = [BPCalendarWeekModel mj_objectWithKeyValues:dic];
        [muArray addObject:model];
    }
    return muArray.copy;
}


- (NSArray *)handleWeekData {
    return @[
                @{
                    @"title":@"日",

                    },
                @{
                    @"title":@"一",
                    
                    },
                @{
                    @"title":@"二",
                    
                    },
                @{
                    @"title":@"三",
                    
                    },
                @{
                    @"title":@"四",
                    
                    },
                @{
                    @"title":@"五",
                    
                    },
                @{
                    @"title":@"六",
                    
                    },
            ];
}


#pragma mark - lazy load methods
- (NSDate *)date {
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}

- (BPPlanCalendarDateModel *)model {
    if (!_model) {
        _model = [[BPPlanCalendarDateModel alloc] init];
    }
    return _model;
}

// **
// *  获取当前月的年份
// */
//- (NSInteger)currentYear:(NSDate *)date{
//
//    NSDateComponents *componentsYear = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    return [componentsYear year];
//}
// **
// *  获取当前月的月份
// */
//- (NSInteger)currentMonth:(NSDate *)date{
//
//    NSDateComponents *componentsMonth = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    return [componentsMonth month];
//}
// **
// *  获取当前是哪一天
// *
// *  @param date date description
// *
// *  @return <#return value description#>
// */
//- (NSInteger)currentDay:(NSDate *)date{
//
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    return [components day];
//}
// **
// *  本月有几天
// *
// *  @param date <#date description#>
// *
// *  @return <#return value description#>
// */
//- (NSInteger)currentMonthOfDay:(NSDate *)date{
//
//    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
//    return totaldaysInMonth.length;
//}
// **
// *  本月第一天是星期几
// *
// *  @param date <#date description#>
// *
// *  @return <#return value description#>
// */
//- (NSInteger)currentFirstDay:(NSDate *)date{
//
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    [calendar setFirstWeekday:1];//1代表周日  2代表周一
//    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    [comp setDay:1];
//    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
//
//    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
//    return firstWeekday - 1;
//}

@end
