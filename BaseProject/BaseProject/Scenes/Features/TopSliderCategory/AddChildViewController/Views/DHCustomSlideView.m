//
//  DHCustomSlideView.m
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/15.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import "DHCustomSlideView.h"
#import "DHCache.h"
#import "BPAppDelegate.h"

#define kDefaultTabbarBottomSpacing 0

@interface DHCustomSlideView ()<DHSlideTabbarDelegate, DHSlideViewDelegate, DHSlideViewDataSource>

@property (nonatomic, strong) DHSlideView *slideView;

@end

@implementation DHCustomSlideView

- (void)commonInit{
    self.tabbarBottomSpacing = kDefaultTabbarBottomSpacing;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)setSlideViewBackgroundColor:(UIColor *)color{
    _slideView.backgroundColor = color;
}

- (void)setup{
    _tabbarView.delegate = self;
    _tabbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_tabbarView];
    [_slideView removeFromSuperview];
    _slideView = [[DHSlideView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_tabbarView.frame) + _tabbarBottomSpacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(_tabbarView.frame) - _tabbarBottomSpacing)];
    _slideView.delegate = self;
    _slideView.dataSource = self;
    _slideView.baseViewController = _baseViewController;
    [self addSubview:_slideView];
    if ([kAppDelegate.selectedNavigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        [_slideView.pan requireGestureRecognizerToFail:kAppDelegate.selectedNavigationController.interactivePopGestureRecognizer];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutBarAndSlide];
}

- (void)layoutBarAndSlide {
    _tabbarView.frame = CGRectMake(_tabbarView.frame.origin.x, 0, kScreenWidth - (2 *_tabbarView.frame.origin.x), _tabbarView.frame.size.height);
    _slideView.frame = CGRectMake(0, CGRectGetHeight(_tabbarView.frame) + _tabbarBottomSpacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(_tabbarView.frame) - _tabbarBottomSpacing);
}

- (void)setBaseViewController:(UIViewController *)baseViewController{
    _slideView.baseViewController = baseViewController;
    _baseViewController = baseViewController;
}

- (void)readloadCustomView
{
    [self layoutBarAndSlide];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [_slideView setSelecteIndex:selectedIndex];
    [_tabbarView setSelectedIndex:selectedIndex];
}

- (void)DHSlideTabbar:(id)slideTabbar selectAtIndex:(NSInteger)index
{
    [_slideView setSelecteIndex:index];
}

- (NSInteger)numberOfControllersInDHSlideView:(DHSlideView *)slideView
{
    return [_delegate numberOfTabsInDHCustomSlideView:self];
}

- (UIViewController *)DHSlideView:(DHSlideView *)slideView viewControllerAtIndex:(NSInteger)index
{
    NSString *key = [NSString stringWithFormat:@"%ld", (long)index];
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    } else{
        UIViewController *viewController = [_delegate DHCustomSlideView:self controllerAtIndex:index];
        [self.cache setObject:viewController forKey:key];
        if(self.maxCacheNumber > 0){
            DHCache *cache = (DHCache *)self.cache;
            if([cache totalVCCount] > self.maxCacheNumber){
                [cache removeFirstObjectInCache];
//                BPLog(@"cache 清除掉了第一个1！！！！！");
//                BPLog(@"还剩几个：%@",@([cache totalVCCount]));
            }
        }
        
        
        return viewController;
    }
}

- (void)DHSlideView:(DHSlideView *)slideView fromIndex:(NSInteger)oldIndex toIndex:(NSInteger)toIndex percent:(float)percent
{
    [_tabbarView switchFromIndex:oldIndex toIndex:toIndex percent:percent];
}

- (void)DHSlideView:(DHSlideView *)slideView didSelectIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(DHCustomSlideView:didSelectedAtIndex:)]) {
        [_delegate DHCustomSlideView:self didSelectedAtIndex:index];
    }
    [_tabbarView setSelectedIndex:index];
}

- (void)DHSlideView:(DHSlideView *)slideView cancelIndex:(NSInteger)index
{
    [_tabbarView setSelectedIndex:index];
}


@end
