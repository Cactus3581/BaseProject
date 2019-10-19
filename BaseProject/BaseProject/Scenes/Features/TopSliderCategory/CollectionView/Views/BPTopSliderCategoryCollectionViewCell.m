//
//  BPTopSliderCategoryCollectionViewCell.m
//  BaseProject
//
//  Created by Ryan on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopSliderCategoryCollectionViewCell.h"
#import "Masonry.h"

@interface BPTopSliderCategoryCollectionViewCell ()
@property (nonatomic, weak) UILabel *label;
@end
@implementation BPTopSliderCategoryCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [UILabel new];
        _label = label;
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _label.text = title;
}

@end
