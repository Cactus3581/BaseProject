//
//  BPPopCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPopCollectionViewCell.h"
#import "Masonry.h"

@implementation BPPopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    self.contentView.backgroundColor = kThemeColor;
    self.button  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.button];
    [self.button setTitle:@"showView" forState:UIControlStateNormal];
    [self.button setTitleColor:kExplicitColor forState:UIControlStateNormal];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).mas_offset(-50);
        make.centerY.equalTo(self.contentView);
    }];
    [self.button addTarget:self action:@selector(showPopView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showPopView {
    if (_delegate && [_delegate respondsToSelector:@selector(nextAction:)]) {
        [_delegate nextAction:self.path];
    }
}

- (void)setDelegate:(id<BPPopCollectionViewCellDelegate>)delegate {
    _delegate = delegate;
}

@end
