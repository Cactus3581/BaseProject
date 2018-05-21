//
//  BPPlanCalendarConfig.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPPlanCalendarConfig.h"
#import "MJExtension.h"
#import "BPCalendar.h"
#import "BPPlanCalendarModel.h"

//请求数据
typedef void(^successDataSource)(BPPlanCalendarModel *model);
typedef void(^failDataSource)(NSString *error);

@interface BPPlanCalendarConfig()
@property (nonatomic,copy) successDataSource successDataSource;
@property (nonatomic,copy) failDataSource failDataSource;
@property (nonatomic,strong) NSArray *generalEventArray;
@property (nonatomic,strong) NSArray *quitPlanArray;
@property (nonatomic,strong) NSArray *planInfo;
@end

@implementation BPPlanCalendarConfig

- (void)handleDataWithId:(NSInteger)courseid success:(void(^)(BPPlanCalendarModel *model))successBlock failure:(void (^)(NSString *error))failBlock {
    _successDataSource = successBlock;
    _failDataSource = failBlock;
    [self requestDataWithId:courseid];
}

#pragma mark - 数据处理
- (BPPlanCalendarModel *)handleData:(NSDictionary *)responseArgs {
    NSMutableDictionary *dic = BPValidateDict(BPValidateDict(BPValidateDict(responseArgs)[@"message"])).mutableCopy;
    [dic setValue:self.generalEventArray forKey:@"generalEventArray"];
    [dic setValue:self.quitPlanArray forKey:@"quitPlanArray"];
    BPPlanCalendarModel *model = [BPPlanCalendarModel mj_objectWithKeyValues:dic];
    return model;
}

#pragma mark - 后台请求
- (void)requestDataWithId:(NSInteger)courseid {    
    BPPlanCalendarModel *model = [self handleData:[self datasourceDic]];
    _successDataSource(model);
}

- (NSDictionary *)datasourceDic {
    NSDictionary *dic = @{
                          @"message":
                                @{
                                  @"remindTime": @"08:00",
                                  @"planInfo":
                                            @[
                                                @{
                                                    @"plan_date":@"2017-10",
                                                    @"plan_days":
                                                        @[
                                                            @{
                                                                @"plan_day":@"2017-10-30",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                            },
                                                            @{
                                                                @"plan_day":@"2017-10-31",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                            },
                                                        ]
                                                },
                                                
                                                @{
                                                    @"plan_date":@"2017-11",
                                                    @"plan_days":
                                                        @[
                                                            @{
                                                                @"plan_day":@"2017-11-01",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-11-02",
                                                                @"is_res":@1,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-11-03",
                                                                @"is_res":@1,
                                                                @"is_finish":@1,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-11-04",
                                                                @"is_res":@1,
                                                                @"is_finish":@1,
                                                                @"is_sign":@1
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-11-05",
                                                                @"is_res":@0,
                                                                @"is_finish":@1,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-11-06",
                                                                @"is_res":@0,
                                                                @"is_finish":@1,
                                                                @"is_sign":@1
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-11-07",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@1
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-11-08",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                        ]
                                                },
                                                
                                                
                                                @{
                                                    @"plan_date":@"2017-12",
                                                    @"plan_days":
                                                        @[
                                                            @{
                                                                @"plan_day":@"2017-12-01",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-12-02",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-12-03",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-12-04",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-12-05",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-12-06",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-12-07",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-12-08",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            
                                                            @{
                                                                @"plan_day":@"2017-12-09",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },
                                                            @{
                                                                @"plan_day":@"2017-12-10",
                                                                @"is_res":@0,
                                                                @"is_finish":@0,
                                                                @"is_sign":@0
                                                                },

                                                            ]
                                                    },
                                                
                                            ]
                                  }

                          };

    return dic;
}
- (NSArray *)generalEventArray {
    if (!_generalEventArray) {
        _generalEventArray = @[
                           @{
                               @"title":@"每日提醒时间",
                               @"is_showArrow":@1,
                               @"time":@"8:00",
                               @"is_showTime":@1,
                               @"fileName":@"",
                               },
                           @{
                               @"title":@"常见问题",
                               @"is_showArrow":@1,
                               @"time":@"",
                               @"is_showTime":@0,
                               @"fileName":@"",
                               },
                           @{
                               @"title":@"全部课程 ",
                               @"is_showArrow":@1,
                               @"time":@"",
                               @"is_showTime":@0,
                               @"fileName":@"",
                               },
                           ];
    }
    return _generalEventArray;
}

- (NSArray *)quitPlanArray {
    if (!_quitPlanArray) {
        _quitPlanArray = @[
                           @{
                            @"title":@"退出计划",
                             @"is_showArrow":@0,
                             @"time":@"",
                             @"is_showTime":@0,
                             @"fileName":@"",
                             },
                           ];
    }
    return _quitPlanArray;
}

@end
