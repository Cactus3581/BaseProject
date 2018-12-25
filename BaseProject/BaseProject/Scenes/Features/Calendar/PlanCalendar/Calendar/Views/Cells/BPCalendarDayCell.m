//
//  BPCalendarDayCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendarDayCell.h"
#import "Masonry.h"
#import "BPCalendarAppearance.h"

@interface BPCalendarDayCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation BPCalendarDayCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleLabel);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(self.backImageView.mas_height).multipliedBy(1);
    }];
}

- (void)initializeSubView {
    self.contentView.backgroundColor = kWhiteColor;

    UILabel *label = [[UILabel alloc] init];
    self.titleLabel = label;
    label.textColor = kBlackColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:label];
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    self.backImageView = backImageView;
    //self.backImageView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:backImageView];
    
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    [self.contentView addSubview:lineView];
    self.lineView.backgroundColor = kLightGrayColor;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(backImageView.mas_height).multipliedBy(1);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(kOnePixel);
    }];
}

- (void)setModel:(BPCalendarDayModel *)model {
    if(model.showTitle) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
        self.lineView.hidden = NO;
    }else {
        self.lineView.hidden = YES;
        self.titleLabel.text = kPlacedString;
    }
    BOOL isUnSign =  model.dayEventMarkMode & PlanCalendarDayNone;
    BOOL isRes =  model.dayEventMarkMode & PlanCalendarDayRes;
    BOOL isFinish =  model.dayEventMarkMode & PlanCalendarDayFinish;
    BOOL isSign =  model.dayEventMarkMode & PlanCalendarDaySign;
    BOOL isToday =  model.dayEventMarkMode & PlanCalendarDayCurrentDay;

//    NSString *str = @"";
//    if (isUnSign) {
//        
//    }
//    if (isRes) {
//        self.titleLabel.text = [str stringByAppendingString:@"休"];
//    }
//    if (isFinish) {
//         self.titleLabel.text = [str stringByAppendingString:@"完成"];
//    }
//    if (isSign) {
//         self.titleLabel.text = [str stringByAppendingString:@"sign"];
//    }
//    if (isToday) {
//        self.titleLabel.text = @"今";
//    }
}

@end
