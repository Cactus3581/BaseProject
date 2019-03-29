//
//  BPAutoresizingViewA.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoresizingViewA.h"
#import "BPAutoresizingViewB.h"
#import "UIView+BPAdd.h"

@interface BPAutoresizingViewA()

@end

@implementation BPAutoresizingViewA

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kPurpleColor;
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
    BPAutoresizingViewB *view = [[BPAutoresizingViewB alloc] init];
    _view = view;
    [self addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).offset(30);
//    }];
}

@end
