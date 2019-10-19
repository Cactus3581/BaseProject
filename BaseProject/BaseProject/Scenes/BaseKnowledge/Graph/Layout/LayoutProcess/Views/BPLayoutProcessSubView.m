//
//  BPLayoutProcessSubView.m
//  BaseProject
//
//  Created by Ryan on 2019/8/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPLayoutProcessSubView.h"
#import "UIView+BPAdd.h"
#import "UIView+BPNib.h"
#import "BPLayoutProcessSubView.h"

@interface BPLayoutProcessSubView()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidthConstraint;

@end


@implementation BPLayoutProcessSubView

/*
 xib 加载时候会调用 initWithCoder 方法, 但是子视图这个时候并没有被实例化，要想使用这些子元素, 需要在 awakeFromNib 中使用和改变.
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    BPLog(@"SubView:initWithCoder");
    return self;
}

/*
 这个方法在initWithCoder:方法后调用，awakeFromNib 从xib或者storyboard加载完毕就会调用；
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    BPLog(@"SubView:awakeFromNib");
}

// frame布局不会回调此方法
- (void)updateConstraints {
    BPLog(@"SubView:updateConstraints");
    //最后记得回调super方法
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 在这里修改子view的frame，不要修改自身的frame，否则可能会导致死循环
    BPLog(@"SubView:layoutSubviews");
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    BPLog(@"SubView:drawRect");
}

// 动画
- (IBAction)buttonAction:(id)sender {
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    return;
    
    self.buttonLeadingConstraint.constant = 100;
    
    // 通知需要更新约束，但是不立即执行
    [self setNeedsUpdateConstraints];
    // 立即更新约束，以执行动态变换
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }];
}

@end
