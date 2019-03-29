//
//  BPMasonryAutoLayoutProcessView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMasonryAutoLayoutProcessView.h"

//http://blog.csdn.net/zpz5789/article/details/50922469
//http://blog.csdn.net/u011623532/article/details/46549227
//http://blog.csdn.net/WQ5201314O/article/details/52184622
//http://www.cocoachina.com/ios/20160530/16522.html
//http://blog.csdn.net/zpz5789/article/details/50922469
//https://blog.cnbluebox.com/blog/2015/02/02/autolayout2/

@interface BPMasonryAutoLayoutProcessView()
@end

@implementation BPMasonryAutoLayoutProcessView

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
        [self initSubViews];//不会被覆盖
    }
    return self;
}

- (void)updateConstraints {
    BPLog(@"UIView:updateConstraints");
    //最后记得回调super方法
    [super updateConstraints];
}

#pragma mark - frame布局不会回调此方法,因为不含content吗？传入的参数是receiver当前的size，返回一个适合的sizesizeToFit可以被手动直接调用sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己
- (CGSize)sizeThatFits:(CGSize)size {
    BPLog(@"UIView:sizeThatFits");
    return [super sizeThatFits:size];
}

#pragma mark - 不应该在子类中被重写，应该重写sizeThatFits
/*
- (void)sizeToFit {
    
}
 */

#pragma mark - 对subviews重新布局

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
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(150);
    }];
    //BPLog(@"%@,%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.button.frame));
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
    //    self.bounds = CGRectMake(0, 0, 200-50, 200-50);
    self.button.bounds = CGRectMake(0, 0,self.width-50,self.height-50);
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.width.height.mas_equalTo(100);
    }];
    
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(-20);
    }];
    
    // 通知需要更新约束，但是不立即执行
    [self setNeedsUpdateConstraints];
    // 立即更新约束，以执行动态变换
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [self needsUpdateConstraints];
    
    [UIView animateWithDuration:0.25 animations:^{
        /*
         setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews
         layoutIfNeeded方法如其名，UIKit会判断该receiver是否需要layout.根据Apple官方文档,layoutIfNeeded方法应该是这样的
         layoutIfNeeded遍历的不是superview链，应该是subviews链
         为什么会用self，因为会调用layoutSubviews
         */
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }];
}

#pragma mark - 一系列的修改frame的操作，如果依赖于父view，最好把它放在layoutSubViews里。
- (void)changeCenter {
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(50);
    }];
}

- (void)changeSize {
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200-50);
    }];
}

- (void)changeSubViewCenter {
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(50);
    }];
}

- (void)changeSubViewSize {
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(150-50);
    }];
}

@end
