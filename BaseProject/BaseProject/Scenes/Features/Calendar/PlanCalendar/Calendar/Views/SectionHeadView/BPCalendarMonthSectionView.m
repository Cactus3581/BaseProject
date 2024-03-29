//
//  BPCalendarMonthSectionView.m
//  BaseProject
//
//  Created by Ryan on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendarMonthSectionView.h"
#import "Masonry.h"
#import "BPCalendarModel.h"
#import "BPCalendarAppearance.h"

@interface BPCalendarMonthSectionView ()
@property (nonatomic,strong) UILabel *label;
@end

@implementation BPCalendarMonthSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)initializeSubView {
    self.backgroundColor = kWhiteColor;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kBlackColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontOfSize:16 weight:UIFontWeightHeavy];
    self.label = label;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)setModel:(BPCalendarModel *)model {
    self.label.text = [NSString stringWithFormat:@"%@年%@月",model.year,model.month];
}

@end
