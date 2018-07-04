//
//  BPDownLoadMoreFilesTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDownLoadMoreFilesTableViewCell.h"
#import "BPDownLoadMacro.h"
#import "UIImageView+WebCache.h"

@interface BPDownLoadMoreFilesTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@end

@implementation BPDownLoadMoreFilesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItem:(BPAudioModel *)item indexPath:(NSIndexPath *)indexPath {
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:item.smallpic] placeholderImage:nil];

    self.titleLabel.text = item.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
