//
//  BPHomeRefreshHeader.m
//  BaseProject
//
//  Created by Ryan on 2018/10/18.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPHomeRefreshHeader.h"

static CGFloat kHeight = 50;

@interface BPHomeRefreshHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation BPHomeRefreshHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    // 设置控件的高度
    self.mj_h = kHeight;
    
    self.ignoredScrollViewContentInsetTop = NO;
    
    self.backgroundColor = kThemeColor;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:loading];
    self.loading = loading;
    
    [self.loading startAnimating];
    self.label.text = @"努力加载中";
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
//    self.label.bounds = self.bounds;
//    self.loading.center = CGPointMake(self.mj_w / 2.0,15);
//    self.label.center = CGPointMake(self.mj_w / 2.0, 40);
//    self.label.bounds = CGRectMake(0, 0, self.width, 20);
//    self.loading.center = CGPointMake(self.mj_w / 2.0,self.mj_h-40);
//    self.label.center = CGPointMake(self.mj_w / 2.0, self.mj_h-20);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    NSValue *value1 = change[@"new"];
    CGPoint point = [value1 CGPointValue];
    //BPLog(@"change1 = %.2f",point.y);
    
    self.label.bounds = CGRectMake(0, 0, self.width, 20);

    
    if (-(point.y) >= kHeight) {
        self.mj_h = -(point.y);
    } else if (-(point.y) < 0) {
        self.mj_h = kHeight;
    }
    self.loading.center = CGPointMake(self.mj_w / 2.0,self.mj_h-40);
    self.label.center = CGPointMake(self.mj_w / 2.0, self.mj_h-20);
    
//    if (-(point.y) >= kHeight) {
//        self.mj_h = -(point.y);
//    } else if (-(point.y) < kHeight) {
//        self.mj_h = kHeight;
//    }
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
//            [self.loading stopAnimating];
//            self.label.text = @"赶紧下拉吖(开关是打酱油滴)";
            break;
        case MJRefreshStatePulling:
//            [self.loading stopAnimating];
//            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
            break;
        case MJRefreshStateRefreshing:
//            self.label.text = @"加载数据中(开关是打酱油滴)";
//            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
//    self.label.textColor = [[UIColor redColor] colorWithAlphaComponent:pullingPercent];
}

@end
