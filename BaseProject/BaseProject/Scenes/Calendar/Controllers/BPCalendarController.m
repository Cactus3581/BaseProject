//
//  BPCalendarController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendarController.h"
#import "BPCalenderView.h"
#import <Masonry.h>

@interface BPCalendarController ()

@property (strong, nonatomic) BPCalenderView *calenderView;


@end

@implementation BPCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configCalendar {
    [self.view addSubview:self.calenderView];
    [self.calenderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
}

- (BPCalenderView *)calenderView {
    if (!_calenderView) {
        _calenderView= [[BPCalenderView alloc] init];
        _calenderView.backgroundColor = kRedColor;
    }
    return _calenderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
