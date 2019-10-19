//
//  BPCollectionViewNestGestureTopCategoryCollectionViewCell.m
//  BaseProject
//
//  Created by Ryan on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCollectionViewNestGestureTopCategoryCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+BPRoundedCorner.h"

@interface BPCollectionViewNestGestureTopCategoryCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

@implementation BPCollectionViewNestGestureTopCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"cactus_theme"]];
    self.coverImageView.backgroundColor = kWhiteColor;
    [self.coverImageView bp_roundedCornerWithRadius:10 cornerColor:kWhiteColor];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
    _backView.backgroundColor = kThemeColor;
    _titleLabel.textColor = _descLabel.textColor = kWhiteColor;
}

@end
