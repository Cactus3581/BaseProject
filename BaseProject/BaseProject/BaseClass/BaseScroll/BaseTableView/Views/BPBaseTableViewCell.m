//
//  BPBaseTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/9.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseTableViewCell.h"
#import <Masonry.h>

static NSString *cellIdentifier = @"BPBaseTableViewCell";

@interface BPBaseTableViewCell()

@end

@implementation BPBaseTableViewCell{
    UILabel *_titleLabel;
    UILabel *_detailLabel;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BPBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell initializeUI];
    }
    return cell;
}

+ (instancetype)xib_cellWithTableView:(UITableView *)tableView {
    BPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell initializeUI];
    return cell;
}

#pragma mark - initialize methods
- (void)initializeUI{
    self.backgroundColor = kWhiteColor;
    UILabel *songNameLabel = [UILabel new];
    _titleLabel = songNameLabel; 
    songNameLabel.numberOfLines = 0;
    [self.contentView addSubview:songNameLabel];
    [songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(widthRatio(10));
        make.top.equalTo(self).offset(widthRatio(2.5));
    }];
    
    UILabel *artistLabel = [UILabel new];
    _detailLabel = artistLabel;
    [self.contentView addSubview:artistLabel];
    [artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(songNameLabel);
        make.top.equalTo(songNameLabel.mas_bottom).offset(widthRatio(2.5));
    }];
    
    _titleLabel.backgroundColor = kRedColor;
    _detailLabel.backgroundColor = kGreenColor;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
