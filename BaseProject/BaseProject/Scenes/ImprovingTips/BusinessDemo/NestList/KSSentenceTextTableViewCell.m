//
//  KSSentenceTextTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSSentenceTextTableViewCell.h"

@interface KSSentenceTextTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indexLabelWidthConstraint;

@end


@implementation KSSentenceTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(KSDailySentenceContentItemDetailModel *)model {
    _model = model;

    
    if (model.hiddenIndexLabel) {
        _indexLabel.hidden = YES;
    } else {
        _indexLabel.hidden = NO;
    }
    
    if (model.customIndex) {
        _indexLabel.text = [NSString stringWithFormat:@"%@、",model.customIndex];
    } else {
        _indexLabel.text = @"";
        _indexLabelWidthConstraint.constant = 0;
    }
    _titleLabel.text = model.content;
}

@end
