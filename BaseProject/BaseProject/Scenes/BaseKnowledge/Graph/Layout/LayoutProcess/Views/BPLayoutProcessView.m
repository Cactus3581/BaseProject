//
//  BPLayoutProcessView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPLayoutProcessView.h"
#import "UIView+BPAdd.h"
#import "UIView+BPNib.h"
#import "BPLayoutProcessSubView.h"

@interface BPLayoutProcessView()

@property (nonatomic,weak) BPLayoutProcessSubView *subView;

@end


@implementation BPLayoutProcessView

- (instancetype)init {
    self = [super init];
    if (self) {
        BPLog(@"UIView:init");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        BPLog(@"UIView:initWithFrame");
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    BPLayoutProcessSubView *subView = [BPLayoutProcessSubView bp_loadInstanceFromNib];
    _subView = subView;
    [subView setBackgroundColor:kRedColor];
    [self addSubview:subView];
    
    // 测试frame 布局
    //subView.bounds = CGRectMake(0, 0, 50, 50);
    //subView.center = CGPointMake(self.width/2.0, self.height/2.0);
    
    // 测试 autoLayout 布局
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(self).multipliedBy(0.5);
    }];
    
    BPLog(@"%@,%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(subView.frame));
}

// frame布局不会回调此方法
- (void)updateConstraints {
    BPLog(@"UIView:updateConstraints");
    //最后记得回调super方法
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 在这里修改子view的frame，不要修改自身的frame，否则可能会导致死循环
    BPLog(@"UIView:layoutSubviews");
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    BPLog(@"UIView:drawRect");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [_subView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(100);
//    }];

    // layout方法

//    [self setNeedsLayout];
//    [self layoutIfNeeded];
    
//    [_subView setNeedsLayout];
//    [_subView layoutIfNeeded];
//
//    // 约束方法
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];

//    [_subView setNeedsUpdateConstraints];
//    [_subView updateConstraintsIfNeeded];
}

@end
