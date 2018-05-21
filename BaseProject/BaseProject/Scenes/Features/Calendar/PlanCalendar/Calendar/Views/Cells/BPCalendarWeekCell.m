//
//  BPCalendarWeekCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/24.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendarWeekCell.h"
#import "Masonry.h"
#import "BPCalendarAppearance.h"

@interface BPCalendarWeekCell ()
@property (nonatomic,strong) UILabel *label;

@end

@implementation BPCalendarWeekCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initalizeSubView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)initalizeSubView {
    self.contentView.backgroundColor = kWhiteColor;
    UILabel *label = [[UILabel alloc] init];
    self.label = label;
    label.textColor = kGreenColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)setStr:(NSString *)str {
    _label.text = str;

}
- (void)setModel:(BPCalendarWeekModel *)model {
    _label.text = model.title;
}

@end
