//
//  BPBaseTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/9.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseTableViewCell.h"
#import <Masonry.h>

static NSString *XWSearchResultCellIdentifier = @"XWSearchResultCellIdentifier";

@implementation BPBaseTableViewCell{
    UILabel *_titleLabel;
    UILabel *_detailLabel;
}

+ (instancetype)xw_cellWithTableView:(UITableView *)tableView {
    BPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XWSearchResultCellIdentifier];
    if (!cell) {
        cell = [[BPBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XWSearchResultCellIdentifier];
        [cell initailizeUI];
    }
    return cell;
}

#pragma mark - initialize methods

- (void)initailizeUI{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *songNameLabel = [UILabel new];
    _titleLabel = songNameLabel;
    //    songNameLabel.font = XFont(14);
    songNameLabel.numberOfLines = 0;
    //    songNameLabel.textColor = XSkyBlueC;
    [self.contentView addSubview:songNameLabel];
    [songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(widthRatio(10));
        make.top.equalTo(self).offset(widthRatio(2.5));
    }];
    
    UILabel *artistLabel = [UILabel new];
    _detailLabel = artistLabel;
    //    artistLabel.font = XFont(12);
    //    artistLabel.textColor = XSkyBlueC;
    [self.contentView addSubview:artistLabel];
    [artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(songNameLabel);
        make.top.equalTo(songNameLabel.mas_bottom).offset(widthRatio(2.5));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

