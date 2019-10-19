//
//  BPAnchorPopView.m
//  BaseProject
//
//  Created by Ryan on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAnchorPopView.h"
#import "Masonry.h"
#import "BPAnchorPopTableView.h"

@interface BPAnchorPopView ()
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) BPAnchorPopTableView *anchorPopTableView;
@end

@implementation BPAnchorPopView

+ (instancetype)arrowPopViewWithHeight:(CGFloat)height targetView:(UIView *)targetView superView:(UIView *)superView {
    BPAnchorPopView *view = [[BPAnchorPopView alloc]init];
    view.height = height;
    view.targetView = targetView;
    view.superView = superView;
    return view;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = kClearColor;
    }
    return self;
}

- (void)showPopView {
    CGRect rc = [_targetView convertRect:_targetView.bounds toView:_superView];
    CGFloat targetViewW = CGRectGetWidth(_targetView.bounds);
    CGFloat targetViewH = CGRectGetHeight(_targetView.bounds);
    CGFloat x = kScreenWidth-rc.origin.x-targetViewW/2.0;
    CGFloat y = rc.origin.y;
    
    /*
     滑动列表，有个重用的问题：
     解决方法：
     首选：不依赖autolayout对象，用确定的值去判断
     次选：遮罩，禁手势
    */
    if (kScreenHeight <=  y + self.height + self.limitH + self.offset) {
        self.layer.anchorPoint = CGPointMake(1, 1);
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_height);
            make.width.mas_equalTo(kScreenWidth-x*2);
            make.centerX.equalTo(_targetView);
            make.centerY.equalTo(_targetView.mas_centerY).offset(-targetViewH/2.0-self.offset);
        }];
    }else {
        self.layer.anchorPoint = CGPointMake(1, 0);
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_height);
            make.width.mas_equalTo(kScreenWidth-x*2);
            make.centerX.equalTo(_targetView);
            make.centerY.equalTo(_targetView.mas_centerY).offset(targetViewH/2.0+self.offset);
        }];
    }
    
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    [self addSubview:toolbar];
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self addSubview:self.anchorPopTableView];
    [self.anchorPopTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)removePopView {
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setTargetView:(UIView *)targetView {
    _targetView = targetView;
}

- (void)setSuperView:(UIView *)superView {
    _superView = superView;
}

- (BPAnchorPopTableView *)anchorPopTableView {
    if (!_anchorPopTableView) {
        _anchorPopTableView = [[BPAnchorPopTableView alloc]init];
    }
    return _anchorPopTableView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        UIImage *bumbleImage = [UIImage imageNamed:@"popview_anchor_arrow"];
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImageView.image = [bumbleImage stretchableImageWithLeftCapWidth:floorf(bumbleImage.size.width/2) topCapHeight:floorf(bumbleImage.size.height/2)];
    }
    return _arrowImageView;
}

@end
