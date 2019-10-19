//
//  BPRotatingScreenView.m
//  BaseProject
//
//  Created by Ryan on 2018/6/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPRotatingScreenView.h"


@interface BPRotatingScreenView()
@property (nonatomic,weak) UIView *view1;
@end

@implementation BPRotatingScreenView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
}

- (void)layoutSubviews {
    //旋转时，会获得通知
    [super layoutSubviews];
}

- (void)initSubViews {
    UIView *view1 = [[UIView alloc] init];
    _view1 = view1;
    [self addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(50);
    }];
    view1.backgroundColor = kExplicitColor;
}

@end
