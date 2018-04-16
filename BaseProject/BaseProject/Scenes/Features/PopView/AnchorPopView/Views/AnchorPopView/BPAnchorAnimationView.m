//
//  BPAnchorAnimationView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAnchorAnimationView.h"


@interface BPAnchorAnimationView ()
@property (strong, nonatomic) UIView *alertView;
@end

@implementation BPAnchorAnimationView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
}

- (void)initialize {
    [self configTheme];
}

//处理数据
- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    [self handleData];
}

- (void)handleData {
    
}

- (void)setAnimationType:(BPAnchorViewAnimationType)animationType {
    _animationType = animationType;
}

- (void)startAnimation:(BPAnchorViewAnimationType)type {
    BPAnchorViewAnimationType Animation1 = NormalShowAnimation | NormalRemoveAnimation;
    
    if (type & NormalShowAnimation) {
        BPLog(@"NormalShowAnimation");
    }else if (type & SpringShowAnimation) {
        [self removeAletView];
    }
    
}

- (void)removeAnimation:(BPAnchorViewAnimationType)type {
    if (type & NormalRemoveAnimation) {
        BPLog(@"NormalShowAnimation");
        [self removeAletView];
    }else if (type & SpringRemoveAnimation) {
        [self removeAletView];
    }
    
}
//开始动画
- (void)startNormalAnimation {
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self showAnimationCompletion];
    }];
}

- (void)startSpringAnimation {
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:0 animations:^{
        self.transform = CGAffineTransformIdentity;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self showAnimationCompletion];
    }];
}

//移除
- (void)removeAletView {
    self.transform = CGAffineTransformIdentity;
    //消失动画
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
    } completion:^(BOOL finished) {
        [self removeAnimationCompletion];
        [self removeFromSuperview];
        if (self) {
            self.alertView.transform = CGAffineTransformIdentity;
            self.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)showAnimationCompletion {
    if (_delegate && [_delegate respondsToSelector:@selector(showAnimationCompletion)]) {
        [_delegate showAnimationCompletion];
    }
}

- (void)removeAnimationCompletion {
    if (_delegate && [_delegate respondsToSelector:@selector(removeAnimationCompletion)]) {
        [_delegate removeAnimationCompletion];
    }
}

//设置颜色
- (void)configTheme {
    self.layer.cornerRadius = 8.0f;
    self.alertView.layer.cornerRadius = 8.0f;
    self.backgroundColor = kGreenColor;
}

@end
