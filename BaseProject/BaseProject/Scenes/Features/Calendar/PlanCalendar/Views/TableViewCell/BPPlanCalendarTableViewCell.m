//
//  BPPlanCalendarTableViewCell.m
//  BaseProject
//
//  Created by Ryan on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPPlanCalendarTableViewCell.h"
#import "BPCalendarView.h"
#import "BPCalendar.h"

@interface BPPlanCalendarTableViewCell ()<BPCalendarViewDelegate>
@property (weak, nonatomic) IBOutlet BPCalendarView *calendarView;

@end

@implementation BPPlanCalendarTableViewCell

- (void)setCalendar:(BPCalendar *)calendar {
    _calendarView.calendar = calendar;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.calendarView.delegate = self;
//    self.calendarView.delegate = self.calendar;
    
    self.contentView.backgroundColor = kWhiteColor;
}

- (void)didSelected:(BPCalendarDayModel *)model {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
