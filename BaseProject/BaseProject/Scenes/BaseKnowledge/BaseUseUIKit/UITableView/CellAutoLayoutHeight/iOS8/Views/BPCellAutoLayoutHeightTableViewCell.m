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
@end

@implementation BPCellAutoLayoutHeightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath {
    _chatHeadImageView.image = [UIImage imageNamed:model.headImage];
    _titleLabel.text = model.text;
    _photoImageView.image = [UIImage imageNamed:model.photoImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
