//
//  BPMainPageSpeakTopCategoryCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMainPageSpeakTopCategoryCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+BPRoundedCorner.h"

@interface BPMainPageSpeakTopCategoryCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

@implementation BPMainPageSpeakTopCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"cactus_theme"]];
    self.coverImageView.backgroundColor = kWhiteColor;
    [self.coverImageView bp_roundedCornerWithRadius:10 cornerColor:kWhiteColor];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
}

@end
