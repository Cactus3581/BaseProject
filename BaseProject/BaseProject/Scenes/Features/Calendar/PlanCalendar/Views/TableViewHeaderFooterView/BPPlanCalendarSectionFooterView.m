//
//  BPPlanCalendarSectionFooterView.m
//  BaseProject
//
//  Created by Ryan on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPPlanCalendarSectionFooterView.h"
@interface BPPlanCalendarSectionFooterView ()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewH;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *planLabel;
@end

@implementation BPPlanCalendarSectionFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    self.lineView.backgroundColor = kLightGrayColor;
    self.lineViewH.constant = kOnePixel;
    self.lineView.hidden = YES;
    self.titleLabel.textColor = kBlackColor;
    self.planLabel.textColor = kBlackColor;

}

@end
