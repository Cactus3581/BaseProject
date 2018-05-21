//
//  BPCalendarView.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPCalendarModel.h"
@class BPCalendar;

@protocol BPCalendarViewDelegate <NSObject>

@optional

- (void)didSelected:(BPCalendarDayModel *)model;

@end


@interface BPCalendarView : UIView

@property (nonatomic,weak) id<BPCalendarViewDelegate>delegate;

@property (nonatomic,strong) BPCalendar *calendar; //xib

+ (instancetype)calendarViewWithCalendar:(BPCalendar *)calendar; // 纯代码

@end
