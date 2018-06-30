//
//  BPTagCollectionCell.m
//  Collectionview
//
//  Created by xiaruzhen on 2016/12/17.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "BPTagCollectionCell.h"

@implementation BPTagCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self layoutUI];
        
    }
    return self;
}
- (void)layoutUI
{
    self.nameLabel  = [[UILabel alloc]init];
    self.nameLabel.textColor = kBlackColor;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font= [UIFont systemFontOfSize:12];
    [self.nameLabel adjustsFontSizeToFitWidth];
    self.nameLabel.backgroundColor = kGreenColor;
    [self.contentView addSubview:self.nameLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width =self.bounds.size.width;
    CGFloat height =self.bounds.size.height;
    self.nameLabel.frame =CGRectMake(0, 0, width, height);
    [self.nameLabel.layer setCornerRadius:5];//设置矩形四个圆角半径
    [self.nameLabel.layer setMasksToBounds:YES];
}

- (void)setNameText:(NSString *)nameText
{
    if (_nameText!=nameText) {
        _nameText = nameText;
    }
    _nameLabel.text = nameText;
}

@end
