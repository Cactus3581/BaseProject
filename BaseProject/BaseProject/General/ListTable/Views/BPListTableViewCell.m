//
//  BPListTableViewCell.m
//  BaseProject
//
//  Created by Ryan on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPListTableViewCell.h"
#import "BPListModel.h"
#import <Masonry.h>

static NSString *cellIdentifier = @"BPListTableViewCell";

@interface BPListTableViewCell ()

@end

@implementation BPListTableViewCell {
    UILabel *_titleLabel;
    UILabel *_detailLabel;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BPListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BPListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell initializeUI];
    }
    return cell;
}

+ (instancetype)xib_cellWithTableView:(UITableView *)tableView {
    BPListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell initializeUI];
    return cell;
}

#pragma mark - initialize methods
- (void)initializeUI {
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

- (void)setModel:(BPListModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
    
    if (model.subVc_array.count) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath) {
        self.textLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row+1,model.title];
    }else {
        self.textLabel.text = model.title;
    }
    
    if (model.fileName.length) {
        self.textLabel.textColor = kBlackColor;
    }else {
        self.textLabel.textColor = kLightGrayColor;
    }
    
    //self.detailTextLabel.text = model.briefIntro;
    
    
    switch (model.importance) {
        case BPImportanceRegular: {
            
        }
            break;
            
        case BPImportanceMedium: {
            
        }
            break;
            
        case BPImportanceHigh: {
            
        }
            break;
            
        default:
            break;
    }
    
    switch (model.completePerformance) {
        case BPCompletePerformanceNone: {
            
        }
            break;
            
        case BPCompletePerformanceDoing: {
            
        }
            break;
            
        case BPCompletePerformanceWillDone: {
            
        }
            break;
            
        case BPCompletePerformanceDone: {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)setModel:(BPListModel *)model {
    _model = model;
    [self setModel:model indexPath:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
