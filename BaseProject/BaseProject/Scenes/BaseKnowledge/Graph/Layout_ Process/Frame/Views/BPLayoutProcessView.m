//
//  BPLayoutProcessView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPLayoutProcessView.h"
#import "UIView+BPAdd.h"

@interface BPLayoutProcessView()
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
        [self initSubViews];
    }
    return self;
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    BPLog(@"UIView:safeAreaInsetsDidChange");
}

#pragma mark - frame布局不会回调此方法
- (void)updateConstraints {
    BPLog(@"UIView:updateConstraints");
    //最后记得回调super方法
    [super updateConstraints];
}

#pragma mark - frame布局不会回调此方法,因为不含content吗？
- (CGSize)sizeThatFits:(CGSize)size {
    BPLog(@"UIView:sizeThatFits");
    return [super sizeThatFits:size];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BPLog(@"UIView:layoutSubviews");
    #pragma mark - 测试是否会循环：不会
    //self.button.bounds = CGRectMake(0, 0,self.width-50,self.height-50);
    //self.bounds = CGRectMake(0, 0, 200-40, 200-40);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    BPLog(@"UIView:drawRect");
}

- (void)dealloc {
    BPLog(@"UIView:dealloc");
}

- (void)initSubViews {
    BPLog(@"initSubViews");
    self.button.frame = CGRectMake(0,0,100,50);
    BPLog(@"%@,%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.button.frame));
}

- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button = button;
        [button setBackgroundColor:kRedColor];
        [self addSubview:button];
    }
    return _button;
}

#pragma mark - 一系列的修改frame的操作，如果依赖于父view，最好把它放在layoutSubViews里。
- (void)changeCenter {
    self.center = CGPointMake(self.width/2.0-10, self.height/2.0-10);
}

- (void)changeSize {
    self.bounds = CGRectMake(0, 0, 200-50, 200-50);
}

- (void)changeSubViewCenter {
    self.button.center = CGPointMake(self.width/2.0-20, self.height/2.0-20);
}

- (void)changeSubViewSize {
    self.button.bounds = CGRectMake(0, 0,self.width-40,self.height-40);
}

@end
