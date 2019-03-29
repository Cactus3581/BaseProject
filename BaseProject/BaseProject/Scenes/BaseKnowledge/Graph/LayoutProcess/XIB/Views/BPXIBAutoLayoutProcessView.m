//
//  BPXIBAutoLayoutProcessView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPXIBAutoLayoutProcessView.h"

@interface BPXIBAutoLayoutProcessView()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonBottomConstraint;

@end

@implementation BPXIBAutoLayoutProcessView

- (IBAction)buttonAction:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.buttonBottomConstraint.constant = -50;
        [self layoutIfNeeded];
    }];
}

/*
 这里说明一个问题, xib 加载时候会调用 initWithCoder 方法, 但是子元素(视图)这个时候并没有被实例化.
 要想使用这些子元素, 需要在 awakeFromNib 中使用和改变.
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    BPLog(@"UIView: xib-1-initWithCoder");
    
    if (self) {
        
    }
    return self;
}

/*
 这个方法在initWithCoder:方法后调用，awakeFromNib 从xib或者storyboard加载完毕就会调用；
 可以这么来理解：一开始经过initWithCoder创建出来的控件是死的，然后通过awakeFromNib来唤醒，所以这会有一个先后的调用顺序。
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    BPLog(@"UIView: xib-2-awakeFromNib");
}

- (instancetype)init {
    self = [super init];
    BPLog(@"UIView: xib-init");
    
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    BPLog(@"UIView: xib-initWithFrame");
    
    if (self) {
        
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    BPLog(@"UIView: xib-3-updateConstraints");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BPLog(@"UIView: xib-4-layoutSubviews");
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    BPLog(@"UIView: safeAreaInsetsDidChange");
}

- (void)layoutMarginsDidChange {
    [super layoutMarginsDidChange];
    BPLog(@"UIView: layoutMarginsDidChange");
}

@end
