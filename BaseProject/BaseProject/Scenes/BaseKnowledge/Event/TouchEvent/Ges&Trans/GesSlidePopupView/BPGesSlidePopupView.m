//
//  BPGesSlidePopupView.h
//  BaseProject
//
//  Created by 夏汝震 on 2021/5/31.
//  Copyright © 2021 cactus. All rights reserved.
//

//https://github.com/QuintGao/GKDYVideo

#import "BPGesSlidePopupView.h"

@interface BPGesSlidePopupView()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, weak) id delegate;
@end

@implementation BPGesSlidePopupView

+ (instancetype)showInView:(UIView *)parentView contentView:(UIView *)contentView delegate:(id)delegate {
    BPGesSlidePopupView *popupView = [[BPGesSlidePopupView alloc] initWithFrame:parentView.frame contentView:contentView delegate:delegate];
    [parentView addSubview:popupView];
    [popupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(parentView);
    }];
    [popupView layoutIfNeeded];
    [popupView updateContentViewY:popupView.frame.size.height];
    [popupView show:true];
    return popupView;
}

- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView delegate:(id)delegate {
    if (self = [super initWithFrame:frame]) {
        self.contentView = contentView;
        self.delegate = delegate;
        
        // 默认不展示内容视图
        [self addSubview:self.contentView];
        
        // 添加手势
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        _tapGesture.delegate = self;
        [self addGestureRecognizer:self.tapGesture];

        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delegate = self;
        [self addGestureRecognizer:self.panGesture];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateContentViewSize];
    [self updateContentViewY:self.frame.size.height - self.contentView.frame.size.height];
}

#pragma mark - 对外提供的接口
- (void)show:(BOOL)isNeedCallBack {
    [UIView animateWithDuration:0.25f animations:^{
        CGFloat y = self.frame.size.height - self.contentView.frame.size.height;
        [self updateContentViewY:y];
        self.backgroundColor = [kGrayColor colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        if (isNeedCallBack && self.delegate && [self.delegate respondsToSelector:@selector(popupViewShowFinished:)]) {
            [self.delegate popupViewShowFinished:self];
        }
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25f animations:^{
        [self updateContentViewY:self.frame.size.height];
        self.backgroundColor = kClearColor;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)reload {
    // 重新对contentView进行布局。常见case：当contentView的数据发生变化时，对height和y值进行刷新
    [self layoutSubviews];
}

#pragma mark - UIGestureRecognizerDelegate
// 获取内部的scroll
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.panGesture) {
        UIView *touchView = touch.view;
        while (touchView != nil) {
            if ([touchView isKindOfClass:[UIScrollView class]]) {
                self.scrollView = (UIScrollView *)touchView;
                break;
            }
            touchView = (UIView *)[touchView nextResponder];
        }
    }
    return YES;
}

// 控制手势事件传递
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.tapGesture) {
        CGPoint point = [gestureRecognizer locationInView:self.contentView];
        if ([self.contentView.layer containsPoint:point] && gestureRecognizer.view == self) {
            // 防止点到scroll区域
            return NO;
        }
    }else if (gestureRecognizer == self.panGesture) {
        return YES;
    }
    return YES;
}

// 是否允许两个手势同时存在
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL result = (gestureRecognizer == self.panGesture) && (otherGestureRecognizer == self.scrollView.panGestureRecognizer);
    return result;
}

#pragma mark - 手势回调事件
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    [self dismiss];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint translation = [panGesture translationInView:self.contentView];
    CGPoint point = [panGesture locationInView:self.scrollView];
    BOOL isOperScrollView = false;
    if ([self.scrollView.layer containsPoint:point]) {
        isOperScrollView = true;
    }
    if (isOperScrollView) {
        // 当手指在scrollView滑动时
        if (self.scrollView.contentOffset.y <= 0) {
            // 当scrollView在最顶部时
            if (translation.y > 0) {
                // 向下拖拽
                [self changeScrollEnabled:NO];
                self.scrollView.contentOffset = CGPointZero;
                CGFloat y = self.contentView.frame.origin.y + translation.y;
                [self updateContentViewY:y];
            }
        }
    }else {
        if (translation.y > 0) {
            // 向下拖拽
            CGFloat y = self.contentView.frame.origin.y + translation.y;
            [self updateContentViewY:y];
        }else if (translation.y < 0) {
            // 向上拖拽
            CGFloat contentMinY = self.frame.size.height - self.contentView.frame.size.height;
            CGFloat contentY = self.contentView.frame.origin.y;
            if (contentY > contentMinY) {
                CGFloat y = MAX(contentY + translation.y, contentMinY);
                [self updateContentViewY:y];
            }
        }
    }

    if (panGesture.state == UIGestureRecognizerStateEnded) {
        [self changeScrollEnabled:YES];
        // 手指离开屏幕时，进行展示/收起contentView
        [self showOrDismissWhenPanEnd];
    }

    // 复位
    [panGesture setTranslation:CGPointZero inView:self.contentView];
}

#pragma mark - 内部方法
- (void)updateContentViewSize {
    CGRect contentFrame = self.contentView.frame;
    contentFrame.size.width = self.frame.size.width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(popupView:heightForContentViewWidth:)]) {
        CGFloat contentHeight = [self.delegate popupView:self heightForContentViewWidth:self.frame.size.width];
        CGFloat suppliedMaxHeight = self.frame.size.height - [self safeAreaHeight];
        contentFrame.size.height = MIN(contentHeight, suppliedMaxHeight);
    }
    self.contentView.frame = contentFrame;
}

- (CGFloat)safeAreaMinY {
    if (@available(iOS 11.0, *)) {
        return self.safeAreaInsets.top;
    } else {
        return self.layoutMargins.top;
    }
}

- (CGFloat)safeAreaHeight {
    if (@available(iOS 11.0, *)) {
        return self.safeAreaInsets.top + self.safeAreaInsets.bottom;
    } else {
        return self.layoutMargins.top + self.layoutMargins.bottom;
    }
}

- (void)updateContentViewY:(CGFloat)y {
    CGRect contentFrame = self.contentView.frame;
    // contentView不能高于容器
    CGFloat minY = [self safeAreaMinY];
    contentFrame.origin.y = MAX(y, minY);
    self.contentView.frame = contentFrame;
    [self updateMaskAlpha];
}

- (void)updateMaskAlpha {
    CGFloat criticalY = self.frame.size.height - self.contentView.frame.size.height;
    CGFloat ratio = (self.contentView.frame.origin.y - criticalY) / self.contentView.frame.size.height;
    CGFloat alpha = 0.5*(1-ratio);
    self.backgroundColor = [kGrayColor colorWithAlphaComponent:alpha];
}

- (void)changeScrollEnabled:(BOOL)enabled {
    self.scrollView.panGestureRecognizer.enabled = enabled;
}

- (void)showOrDismissWhenPanEnd {
    CGFloat criticalY = (self.frame.size.height - self.contentView.frame.size.height/2);
    if (self.contentView.frame.origin.y > criticalY) {
        [self dismiss];
    }else {
        [self show:false];
    }
}

@end
