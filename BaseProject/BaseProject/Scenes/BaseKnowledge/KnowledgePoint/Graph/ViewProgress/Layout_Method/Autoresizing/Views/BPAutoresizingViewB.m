//
//  BPAutoresizingViewB.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoresizingViewB.h"
#import "UIView+BPAdd.h"

@interface BPAutoresizingViewB()

@end

@implementation BPAutoresizingViewB

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRedColor;
        [self initSubViews];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _view.bounds = CGRectMake(0, 0, self.width/2.0-10, self.height/2.0-10);
    _view.center = CGPointMake(self.width/2.0, self.height/2.0);
}

- (void)initSubViews {
    UIView *view = [[UIView alloc] init];
    _view = view;
    [self addSubview:view];
    view.backgroundColor = kGreenColor;
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).offset(30);
//    }];
}

@end
