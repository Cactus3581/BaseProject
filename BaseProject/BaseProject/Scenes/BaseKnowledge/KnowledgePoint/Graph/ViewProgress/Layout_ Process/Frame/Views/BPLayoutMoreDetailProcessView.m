//
//  BPLayoutMoreDetailProcessView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPLayoutMoreDetailProcessView.h"
#import "UIView+BPAdd.h"

@interface BPLayoutMoreDetailProcessView()
@property (nonatomic,weak) UIButton *button;
@end

@implementation BPLayoutMoreDetailProcessView

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
        [self initSubViews];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    BPLog(@"UIView:requiresConstraintBasedLayout");
    return YES;
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    BPLog(@"UIView:safeAreaInsetsDidChange");
}

- (void)layoutMarginsDidChange {
    [super layoutMarginsDidChange];
    BPLog(@"UIView:layoutMarginsDidChange");
}

- (void)updateConstraints {
    BPLog(@"UIView:updateConstraints");
    //最后记得回调super方法
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BPLog(@"UIView:layoutSubviews");
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    BPLog(@"UIView:drawRect");
}

//通知视图指定子视图已经添加
- (void)didAddSubview:(UIView *)subview {
    BPLog(@"UIView:didAddSubview");
}

//通知视图将要移除指定的子视图
- (void)willRemoveSubview:(UIView *)subview {
    BPLog(@"UIView:willRemoveSubview");
}

//通知视图将要移动到一个新的父视图中
- (void)willMoveToSuperview:(UIView *)newSuperview {
    BPLog(@"UIView:willMoveToSuperview");
}

//通知视图已经移动到一个新的父视图中
- (void)didMoveToSuperview {
    BPLog(@"UIView:didMoveToSuperview");
}

//通知视图将要移动到一个新的window中
- (void)willMoveToWindow:(UIWindow *)newWindow {
    BPLog(@"UIView:willMoveToWindow");
}

//通知视图已经移动到一个新的window中
- (void)didMoveToWindow {
    BPLog(@"UIView:didMoveToWindow");
}

- (void)sizeToFit {
    BPLog(@"UIView:sizeToFit");
}

- (CGSize)sizeThatFits:(CGSize)size {
    BPLog(@"UIView:sizeThatFits");
    return size;
}

- (void)dealloc {
    BPLog(@"UIView:dealloc");
}

- (void)initSubViews {
    BPLog(@"initSubViews");
    //    self.button.frame = CGRectMake(0,0,100,50);
}

- (UIButton *)button {
    if (!_button) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        _button = bt;
        [bt addTarget:self action:@selector(changeFrame) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:@"修改约束" forState:UIControlStateNormal];
        [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
        [bt setBackgroundColor:kRedColor];
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:bt];
    }
    return _button;
}

- (void)changeFrame {
    self.button.bounds = CGRectMake(0, 0,self.width-30,self.height-30);
    self.button.center = CGPointMake(self.width/2.0, self.height/2.0);
}

- (void)changeSubViewFrame {
    self.button.bounds = CGRectMake(0, 0,self.width-40,self.height-40);
    self.button.center = CGPointMake(self.width/2.0, self.height/2.0);
}

@end

