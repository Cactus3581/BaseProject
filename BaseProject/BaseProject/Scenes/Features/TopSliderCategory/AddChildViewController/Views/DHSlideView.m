//
//  DHSlideView.m
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/14.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import "DHSlideView.h"

#define kPanSwitchOffsetThreshold 50.0f

@interface DHSlideView ()<UIGestureRecognizerDelegate>
{
    NSInteger _oldIndex;
    NSInteger _panToIndex;
    CGPoint _panStartPoint;
    BOOL _isSwitch;
}
@property (nonatomic, strong)  UIViewController *oldViewController;
@property (nonatomic, strong) UIViewController *willViewController;

@end

@implementation DHSlideView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _oldIndex = -1;
    _isSwitch = NO;
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    _pan.delegate = self;
    [self addGestureRecognizer:_pan];
}

- (NSInteger)selecteIndex
{
    return _oldIndex;
}

- (void)setSelecteIndex:(NSInteger)selecteIndex
{
    if (selecteIndex != _oldIndex) {
        [self switchToIndex:selecteIndex];
    }
}
//手势处理
- (void)panHandler:(UIPanGestureRecognizer *)recognizer
{
    if (_oldIndex < 0) {
        return;
    }
    CGPoint point = [recognizer translationInView:self];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _panStartPoint = point;
        [_oldViewController beginAppearanceTransition:NO animated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        NSInteger panToIndex = -1;
        float offsetx = point.x - _panStartPoint.x;
        if (offsetx > 0) {
            panToIndex = _oldIndex - 1;
        }else if (offsetx < 0) {
            panToIndex = _oldIndex + 1;
        }
        if (panToIndex != _panToIndex) {
            if (_willViewController) {
                [self removeWill];
            }
        }
        if (panToIndex < 0 || panToIndex >= [_dataSource numberOfControllersInDHSlideView:self]) {
            _panToIndex = panToIndex;
            [self repositionForOffsetX:offsetx/2.0];
        } else {
            if (panToIndex != _panToIndex) {
                _willViewController = [_dataSource DHSlideView:self viewControllerAtIndex:panToIndex];
                [_baseViewController addChildViewController:_willViewController];
                [_willViewController willMoveToParentViewController:_baseViewController];
                [_willViewController beginAppearanceTransition:YES animated:YES];
                [self addSubview:_willViewController.view];
                _panToIndex = panToIndex;
            }
            [self repositionForOffsetX:offsetx];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        float offsetx = point.x - _panStartPoint.x;
        if (_panToIndex >= 0 && _panToIndex < [_dataSource numberOfControllersInDHSlideView:self] && _panToIndex != _oldIndex) {
            if (fabs(offsetx) > kPanSwitchOffsetThreshold) {
                NSTimeInterval animatedTime = fabs(self.frame.size.width - fabs(offsetx)) / self.frame.size.width * 0.4;
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView animateWithDuration:animatedTime animations:^{
                    [self repositionForOffsetX:offsetx > 0 ? self.bounds.size.width : -self.bounds.size.width];
                } completion:^(BOOL finished) {
                    [self removeOld];
                    if (_panToIndex >= 0 && _panToIndex < [_dataSource numberOfControllersInDHSlideView:self]) {
                        [_willViewController endAppearanceTransition];
                        [_willViewController didMoveToParentViewController:self.baseViewController];
                        _oldIndex = _panToIndex;
                        _oldViewController = _willViewController;
                        _willViewController = nil;
                        _panToIndex = -1;
                    }
                    if (_delegate && [_delegate respondsToSelector:@selector(DHSlideView:didSelectIndex:)]) {
                        [_delegate DHSlideView:self didSelectIndex:_oldIndex];
                    }
                }];
            } else {
                [self backToOldWithOffset:offsetx];
            }
        } else {
            [self backToOldWithOffset:offsetx];
        }
    }
}

- (void)showAtIndex:(NSInteger)index
{
    if (_oldIndex != index) {
        [self removeOld];
        UIViewController *viewContoller = [_dataSource DHSlideView:self viewControllerAtIndex:index];
        [_baseViewController addChildViewController:viewContoller];
        viewContoller.view.frame = self.bounds;
        [self addSubview:viewContoller.view];
        [viewContoller didMoveToParentViewController:_baseViewController];
        _oldIndex = index;
        _oldViewController = viewContoller;
        if (_delegate && [_delegate respondsToSelector:@selector(DHSlideView:didSelectIndex:)]) {
            [_delegate DHSlideView:self didSelectIndex:index];
        }
    }
}

- (void)removeOld
{
    [self removeViewController:_oldViewController];
    [_oldViewController endAppearanceTransition];
    _oldViewController = nil;
    _oldIndex = -1;
//    BPLog(@"看看remove old 走了多少遍");
}

- (void)removeWill
{
    [_willViewController beginAppearanceTransition:NO animated:NO];
    [self removeViewController:_willViewController];
    [_willViewController endAppearanceTransition];
    _willViewController = nil;
    _panToIndex = -1;
}

- (void)removeViewController:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void)repositionForOffsetX:(CGFloat)offsetx
{
    float x = 0.0f;
    if (_panToIndex < _oldIndex) {
        x = self.bounds.origin.x - CGRectGetWidth(self.bounds) + offsetx;
    }else if (_panToIndex > _oldIndex) {
        x = self.bounds.origin.x + CGRectGetWidth(self.bounds) + offsetx;
    }
    _oldViewController.view.frame = CGRectMake(self.bounds.origin.x + offsetx, self.bounds.origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    if (_panToIndex >= 0 && _panToIndex < [_dataSource numberOfControllersInDHSlideView:self]) {
        _willViewController.view.frame = CGRectMake(x, self.bounds.origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    }
    if (_delegate && [_delegate respondsToSelector:@selector(DHSlideView:fromIndex:toIndex:percent:)]) {
        [_delegate DHSlideView:self fromIndex:_oldIndex toIndex:_panToIndex percent:fabs(offsetx)/CGRectGetWidth(self.bounds)];
    }
}

- (void)backToOldWithOffset:(CGFloat)offsetx
{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:0.3 animations:^{
        [self repositionForOffsetX:0];
    } completion:^(BOOL finished) {
        if (_panToIndex >= 0 && _panToIndex < [_dataSource numberOfControllersInDHSlideView:self] && _panToIndex != _oldIndex) {
            [_oldViewController beginAppearanceTransition:YES animated:NO];
            [self removeWill];
            [_oldViewController endAppearanceTransition];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(DHSlideView:cancelIndex:)]) {
            [_delegate DHSlideView:self cancelIndex:_oldIndex];
        }
    }];
}

- (void)switchToIndex:(NSInteger)index{
    if (index == _oldIndex) {
        return;
    }
    if (_isSwitch) {
        return;
    }
    if (_oldViewController != nil && _oldViewController.parentViewController == self.baseViewController) {
        _isSwitch = YES;
        UIViewController *oldvc = _oldViewController;
        UIViewController *newvc = [self.dataSource DHSlideView:self viewControllerAtIndex:index];
        [oldvc willMoveToParentViewController:nil];
        [self.baseViewController addChildViewController:newvc];
        CGRect nowRect = oldvc.view.frame;
        CGRect leftRect = CGRectMake(nowRect.origin.x-nowRect.size.width, nowRect.origin.y, nowRect.size.width, nowRect.size.height);
        CGRect rightRect = CGRectMake(nowRect.origin.x+nowRect.size.width, nowRect.origin.y, nowRect.size.width, nowRect.size.height);
        CGRect newStartRect;
        CGRect oldEndRect;
        if (index > _oldIndex) {
            newStartRect = rightRect;
            oldEndRect = leftRect;
        } else {
            newStartRect = leftRect;
            oldEndRect = rightRect;
        }
        newvc.view.frame = newStartRect;
        [newvc willMoveToParentViewController:self.baseViewController];
        [self.baseViewController transitionFromViewController:oldvc toViewController:newvc duration:0.4 options:0 animations:^{
            newvc.view.frame = nowRect;
            oldvc.view.frame = oldEndRect;
        } completion:^(BOOL finished) {
            [oldvc removeFromParentViewController];
            [newvc didMoveToParentViewController:self.baseViewController];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(DHSlideView:didSelectIndex:)]) {
                [self.delegate DHSlideView:self didSelectIndex:index];
            }
            _isSwitch = NO;
        }];
        _oldIndex = index;
        _oldViewController = newvc;
    } else {
        [self showAtIndex:index];
    }
    _willViewController = nil;
    _panToIndex = -1;
}

#pragma mark -- gesture recognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![touch.view isKindOfClass:[UIControl class]]; //优先响应系统控件
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //只响应水平方向
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        return fabs(point.x) > fabs(point.y);
    }
    return YES;
}

@end
