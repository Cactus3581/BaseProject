//
//  KSSlideCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/5/19.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "KSSlideCell.h"

@implementation KSSlideCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.labelFont = 11;
        self.selectedColor = 1;
        self.cornus = 23;
        self.unselectedColor = 66;
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI
{
    self.nameLabel  = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    _nameLabel.textColor = kLightGrayColor;
//    _nameLabel.layer.borderColor =kLightGrayColor.CGColor;
//    _nameLabel.backgroundColor =kWhiteColor;
//    _nameLabel.layer.cornerRadius = 24/2;
//    _nameLabel.layer.borderWidth = 1;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width =self.bounds.size.width;
    CGFloat height =self.bounds.size.height;
    _nameLabel.frame =CGRectMake(0, 0, width, height);
}

- (void)setNameText:(NSString *)nameText
{
    if (_nameText!=nameText) {
        _nameText = nameText;
    }
    _nameLabel.text = nameText;
}
- (void)setIsSelected:(BOOL)isSelected
{
    if (_isSelected!=isSelected) {
        _isSelected = isSelected;
    }
    if (isSelected) {
        _nameLabel.textColor = kRedColor;
        _nameLabel.layer.borderColor = kRedColor.CGColor;
    }else
    {
        _nameLabel.textColor = kLightGrayColor;
        _nameLabel.layer.borderColor = kLightGrayColor.CGColor;
    }
}


//-(void)setSelectedColor:(NSInteger)selectedColor
//{
//    if (_selectedColor!=selectedColor) {
//        _selectedColor = selectedColor;
//    }
//    _nameLabel.textColor = KSColor(selectedColor);
//    _nameLabel.layer.borderColor =KSColor(selectedColor).CGColor;
//
//
//}
//
//-(void)setUnselectedColor:(NSInteger)unselectedColor
//{
//    if (_unselectedColor!=unselectedColor) {
//        _unselectedColor = unselectedColor;
//    }
//    _nameLabel.textColor = KSColor(unselectedColor);
//    _nameLabel.layer.borderColor =KSColor(unselectedColor).CGColor;
//}



@end
