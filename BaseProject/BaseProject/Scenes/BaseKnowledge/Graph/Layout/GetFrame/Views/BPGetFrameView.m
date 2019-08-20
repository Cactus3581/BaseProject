//
//  BPGetFrameView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPGetFrameView.h"

@interface BPGetFrameView()
@property (nonatomic,weak) UIView *view;
@end


@implementation BPGetFrameView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

#pragma mark - 方法三
- (void)layoutSubviews {
    [super layoutSubviews];
    BPLog(@"getFrameView layoutSubviews = %@",NSStringFromCGRect(self.frame));
}

- (void)initSubViews {
    
    UIView *view = [[UIView alloc] init];
    _view = view;
    view.backgroundColor = kExplicitColor;
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(self.width/2.0);
    }];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    BPLog(@"view init = %@",NSStringFromCGRect(view.frame));// 0，0，0，0
}

@end
