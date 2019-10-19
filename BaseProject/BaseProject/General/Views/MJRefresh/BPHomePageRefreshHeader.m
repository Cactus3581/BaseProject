//
//  BPHomePageRefreshHeader.m
//  BaseProject
//
//  Created by Ryan on 2018/10/26.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPHomePageRefreshHeader.h"

static CGFloat kHeight = 50;

@interface BPHomePageRefreshHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation BPHomePageRefreshHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    // 设置控件的高度
    self.mj_h = kHeight;
    
    self.ignoredScrollViewContentInsetTop = NO;
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    self.label = label;
    label.textColor = kThemeColor;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label.text = @"努力加载中";

    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
    //self.loading.color = kThemeColor;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    self.loading.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5 - 15);
    self.label.bounds = CGRectMake(0, 0, self.mj_w, 20);
    self.label.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5 + 10);
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle://普通闲置状态
            [self.loading stopAnimating];
            break;
        case MJRefreshStateWillRefresh://即将刷新的状态
            [self.loading startAnimating];
            break;
        case MJRefreshStatePulling://松开就可以进行刷新的状态
            [self.loading startAnimating];
            break;
        case MJRefreshStateRefreshing://正在刷新中的状态
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

@end
