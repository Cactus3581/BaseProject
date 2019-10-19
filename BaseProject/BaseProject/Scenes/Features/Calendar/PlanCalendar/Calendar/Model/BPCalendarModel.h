//
//  BPCalendarModel.h
//  BaseProject
//
//  Created by Ryan on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPCalendarConst.h"

@interface BPCalendarModel : NSObject
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *year;
@property (nonatomic,copy) NSString *month;
@property (nonatomic,strong) NSArray *weekArray;
@property (nonatomic,strong) NSArray *dayArray;
@end

@interface BPCalendarWeekModel : NSObject
@property (nonatomic,copy) NSString *title;
@end

@interface BPCalendarDayModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,assign) BOOL showTitle;//是否显示title
@property (nonatomic, assign) BPPlanCalendarDayMode dayEventMarkMode; //模式
@end
