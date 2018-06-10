//
//  BPTopCategoryListTagCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryListTagCollectionViewCell.h"

@interface BPTopCategoryListTagCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation BPTopCategoryListTagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = kDarkTextColor;
    self.titleLabel.backgroundColor = kGreenColor;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel.layer setCornerRadius:35/2.0];
    [self.titleLabel.layer setMasksToBounds:YES];
}

- (void)setModel:(BPTopCategorySecondCategoryModel *)model {
    _model = model;
    _titleLabel.text = model.name;
    if (model.isSelected) {
        self.titleLabel.textColor = kGreenColor;
        self.titleLabel.backgroundColor = [kGreenColor colorWithAlphaComponent:0.08];
    }else {
        self.titleLabel.textColor = kDarkTextColor;
        self.titleLabel.backgroundColor = kLightGrayColor;
    }
}

@end
