//
//  BPPlanGeneralTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPPlanGeneralTableViewCell.h"
@interface BPPlanGeneralTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewH;

@end
@implementation BPPlanGeneralTableViewCell

- (void)setModel:(BPPlanCalendarGeneralModel *)model {
    _titleLabel.text = model.title;
    if (model.is_showTime) {
        _timeLabel.text = model.time;
        _timeLabel.hidden = NO;
    }else {
        _timeLabel.hidden = YES;
    }
    
    if (model.is_showArrow) {
        _arrowImageView.image = [UIImage imageNamed:@""];
        _arrowImageView.hidden = NO;
    } else {
        _arrowImageView.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineViewH.constant = kOnePixel;
    self.contentView.backgroundColor = kWhiteColor;
    self.lineView.backgroundColor = kLightGrayColor;
    self.titleLabel.textColor = kBlackColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
