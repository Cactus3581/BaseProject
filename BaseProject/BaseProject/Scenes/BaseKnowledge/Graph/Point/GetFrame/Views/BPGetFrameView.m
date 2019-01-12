//
//  BPGetFrameView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPGetFrameView.h"

@interface BPGetFrameView()
@property (nonatomic,weak) UIView *view1;
@end


@implementation BPGetFrameView

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

#pragma mark - 方法2.2
- (void)layoutSubviews {
    [super layoutSubviews];
//    [_view1 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(self.width/2.0);
//    }];
}

- (void)getFrame {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)initSubViews {
    UIView *view1 = [[UIView alloc] init];
    _view1 = view1;
    [self addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(self.width/2.0);
    }];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    view1.backgroundColor = kExplicitColor;
}

@end
