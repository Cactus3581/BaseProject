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
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UILabel *detailLabel;
@end

@implementation BPListTableViewCell 

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = kWhiteColor;
    UILabel *titleLabel = [UILabel new];
    _titleLabel = titleLabel;
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(widthRatio(10));
        make.top.equalTo(self).offset(widthRatio(2.5));
    }];
    
    UILabel *artistLabel = [UILabel new];
    _detailLabel = artistLabel;
    [self.contentView addSubview:artistLabel];
    [artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(widthRatio(2.5));
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

// 高亮状态
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [self setHighlightedColor: highlighted];
}

// 选中状态
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setHighlightedColor: selected];
}

- (void)setHighlightedColor:(BOOL)highlighted {
    if (highlighted) {
        self.backgroundColor = kLightGrayColor;
    } else {
        // 增加延迟消失动画效果，提升用户体验
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.backgroundColor = kWhiteColor;
        } completion:nil];
    }
}

@end
