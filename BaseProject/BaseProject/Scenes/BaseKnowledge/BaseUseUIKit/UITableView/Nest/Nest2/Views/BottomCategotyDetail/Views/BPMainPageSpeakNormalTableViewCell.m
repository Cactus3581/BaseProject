//
//  BPMainPageSpeakNormalTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMainPageSpeakNormalTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+BPRoundedCorner.h"

@interface BPMainPageSpeakNormalTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImageView;
@end

@implementation BPMainPageSpeakNormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"cactus_theme"]];
    self.coverImageView.backgroundColor = [UIColor whiteColor];
    [self.coverImageView bp_roundedCornerWithRadius:10 cornerColor:[UIColor darkTextColor]];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
}

- (void)setIndexpath:(NSIndexPath *)indexPath index:(NSInteger)index {
    self.desclabel.text = self.titleLabel.text = [NSString stringWithFormat:@"我是第%d排第%d行的Label",index,indexPath.row];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
