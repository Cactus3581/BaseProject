//
//  BPCalendar.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendar.h"
#import "NSDate+BPUtilities.h"
#import "BPCalendarDataSource.h"
#import "BPCalendarModel.h"
#import "BPCalendarConst.h"

@interface BPCalendar() {
    dispatch_block_t _success;
    dispatch_block_t _fail;
}
@property (nonatomic,strong) BPCalendarDataSource *dataSource;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) BPCalendarModel *model;
@property (nonatomic,assign) NSInteger calendarViewRows;
@property (nonatomic,assign) CGFloat  calendarViewHeight;
@property (nonatomic,strong) BPPlanCalendarDateModel *calendarModel; //server model
@end

@implementation BPCalendar

@synthesize show_ymView = _show_ymView;
@synthesize show_weekView = _show_weekView;

#pragma mark - init
+ (instancetype)calendarWithModel:(BPPlanCalendarDateModel *)model {
    BPCalendar *calendar = [[self alloc] initWithModel:model];
    return calendar;
}

- (instancetype)initWithModel:(BPPlanCalendarDateModel *)model {
    self = [super init];
    if (self) {
        BPPlanCalendarDayModel *dayModel = BPValidateArrayObjAtIdx(model.plan_days, 0);
        if (dayModel) {
            NSDate *date = [NSDate bp_dateWithString:dayModel.plan_day format:@"yyyy-MM-dd"];
            self.date = date;
            self.calendarModel = model;
            [self configDefaultDate];
        }
    }
    return self;
}

- (void)configCalendarWithSussess:(dispatch_block_t)success fail:(dispatch_block_t)fail {
    _success = success;
    _fail = fail;
    [self handleData];
}

#pragma mark default Data
- (void)configDefaultDate {
    self.yearMonthHeight = BPCalenarYearHeight;
    self.weekHight = BPCalenarWeekHeight;
    self.dayHight = BPCalenarDayHeight;
    self.show_ymView = YES;
    self.show_weekView = YES;
}

#pragma mark - handle data
- (void)handleData {
    __block BOOL result = false;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        result = [self configCalendar];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result) {
                _success();
            }else {
                _fail();
            }
        });
    });
}

- (BOOL)configCalendar {
    self.model = [self.dataSource handleData];
    if (self.model.dayArray.count ) {
        NSInteger remainder =  self.model.dayArray.count % BPCalenarWeeBPeven ;//余数
        NSInteger consult =  self.model.dayArray.count / BPCalenarWeeBPeven ;//商
        if (remainder == 0) {
            self.calendarViewRows = consult;
        }else {
            self.calendarViewRows = self.model.dayArray.count / BPCalenarWeeBPeven + 1;
        }
    }else {
        self.calendarViewRows = 0.0f;
    }
    self.calendarViewHeight = self.calendarViewRows * self.dayHight + self.weekHight + self.yearMonthHeight;
    return YES;
}

#pragma mark setter
- (void)setShow_ymView:(BOOL)show_ymView {
    _show_ymView = show_ymView;
    if (!show_ymView) {
        self.yearMonthHeight = 0.0f;
    }
}

- (void)setShow_weekView:(BOOL)show_weekView {
    _show_weekView = show_weekView;
    if (!show_weekView) {
        self.weekHight = 0.0f;
    }
}

#pragma mark getter，lazy load methods
- (BPCalendarModel *)model {
    if (!_model) {
        _model = [[BPCalendarModel alloc] init];
    }
    return _model;
}

- (NSDate *)date {
    if (!_date) {
        _date = [[NSDate alloc] init];
    }
    return _date;
}

- (BPCalendarDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [BPCalendarDataSource calendarDataSourceWithDate:self.date calendarModel:self.calendarModel];
    }
    return _dataSource;
}

@end
