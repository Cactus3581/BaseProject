//
//  BPTestTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTestTableViewCell.h"

@interface BPTestTableViewCell()
@property (nonatomic,weak) UILabel *label;
@end

@implementation BPTestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    label.backgroundColor = kGreenColor;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.centerY.equalTo(self.contentView);
    }];
    self.label = label;
}

- (void)setModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    self.label.text = model.name;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
