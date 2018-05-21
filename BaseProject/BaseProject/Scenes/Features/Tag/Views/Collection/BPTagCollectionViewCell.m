//
//  BPTagCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagCollectionViewCell.h"
@interface BPTagCollectionViewCell()
@property (nonatomic,weak) UILabel *label;
@end

@implementation BPTagCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews {
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.label = label;
    self.label.textColor = kPurpleColor;
    self.label.backgroundColor = kGreenColor;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:14];
}

- (void)setText:(NSString *)text {
    self.label.text = text;
}

@end
