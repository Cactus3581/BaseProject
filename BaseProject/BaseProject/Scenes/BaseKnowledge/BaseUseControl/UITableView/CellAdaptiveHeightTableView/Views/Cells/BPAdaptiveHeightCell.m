//
//  BPAdaptiveHeightCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAdaptiveHeightCell.h"

@interface BPAdaptiveHeightCell ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation BPAdaptiveHeightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kGreenColor;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSUbViews];
    }
    return self;
}

- (void)initSUbViews {
    self.label = [[UILabel alloc] init];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setContent:(NSString *)content {
    _label.text = content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
