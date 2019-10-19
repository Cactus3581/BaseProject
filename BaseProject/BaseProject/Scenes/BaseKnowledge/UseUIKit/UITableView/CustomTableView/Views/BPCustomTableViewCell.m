//
//  BPCustomTableViewCell.m
//  BaseProject
//
//  Created by Ryan on 2019/8/20.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPCustomTableViewCell.h"

@interface BPCustomTableViewCell()

@end


@implementation BPCustomTableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        self.backgroundColor = kWhiteColor;
        UILabel *label = [[UILabel alloc] init];
        _label = label;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(15);
            make.top.bottom.trailing.equalTo(self);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        _lineView = lineView;
        lineView.backgroundColor = kLightGrayColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(15);
            make.height.mas_equalTo(kOnePixel);
            make.bottom.trailing.equalTo(self);
        }];
    }
    return self;
}

@end
