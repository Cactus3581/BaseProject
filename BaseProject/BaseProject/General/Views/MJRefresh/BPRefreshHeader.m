//
//  BPRefreshHeader.m
//  WPSExcellentClass
//
//  Created by xiaruzhen on 2018/10/18.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPRefreshHeader.h"

@interface BPRefreshHeader()
@end

@implementation BPRefreshHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    // 设置控件的高度
    self.mj_h = kRefreshHeaderHeight;
    
    [self setTitle:kHeaderPullToRefreshText forState:MJRefreshStateIdle];
    [self setTitle:kHeaderReleaseToRefreshText forState:MJRefreshStatePulling];
    [self setTitle:kHeaderRefreshingText forState:MJRefreshStateRefreshing];
    
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    self.stateLabel.hidden = NO;
    self.stateLabel.textColor = [UIColor lightGrayColor];

    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
    self.lastUpdatedTimeLabel.hidden = YES; //隐藏更新时间
    self.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];

    //self.loadingView.color = kThemeColor;
}

@end

