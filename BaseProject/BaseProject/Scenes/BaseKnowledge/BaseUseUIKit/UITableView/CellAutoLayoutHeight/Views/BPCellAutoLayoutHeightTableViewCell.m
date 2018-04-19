//
//  BPCellAutoLayoutHeightTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCellAutoLayoutHeightTableViewCell.h"

@interface BPCellAutoLayoutHeightTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *chatHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineBottomConstraint;
@end

@implementation BPCellAutoLayoutHeightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =  kWhiteColor;
    self.backgroundView = view;
    self.lineView.backgroundColor = kLightGrayColor;
    self.lineBottomConstraint.constant = kOnePixel;
}

- (void)set1stModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath {
    _chatHeadImageView.image = [UIImage imageNamed:model.headImage];
    _titleLabel.text = model.text;
    _nameLabel.text = model.name;
    _photoImageView.image = [UIImage imageNamed:model.photoImage];
    _chatHeadImageView.layer.masksToBounds = YES;
    _photoImageView.layer.masksToBounds = YES;
}

- (void)set2ndModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath {
    //必须设置label的最大宽度，不然系统无法计算label的最大高度
    CGFloat preferredWidth = kScreenWidth - (15+20+15) - (15);
    _nameLabel.preferredMaxLayoutWidth = preferredWidth;
    _titleLabel.preferredMaxLayoutWidth = preferredWidth;
    _chatHeadImageView.image = [UIImage imageNamed:model.headImage];
    _titleLabel.text = model.text;
    _nameLabel.text = model.name;
    _photoImageView.image = [UIImage imageNamed:model.photoImage];
    _chatHeadImageView.layer.masksToBounds = YES;
    _photoImageView.layer.masksToBounds = YES;
}

- (void)set3rdModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath {
    _chatHeadImageView.image = [UIImage imageNamed:model.headImage];
    _titleLabel.text = model.text;
    _nameLabel.text = model.name;
    _photoImageView.image = [UIImage imageNamed:model.photoImage];
    _chatHeadImageView.layer.masksToBounds = YES;
    _photoImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
