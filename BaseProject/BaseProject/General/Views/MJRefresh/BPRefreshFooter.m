//
//  BPRefreshFooter.m
//  WPSExcellentClass
//
//  Created by xiaruzhen on 2018/10/18.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPRefreshFooter.h"

@interface BPRefreshFooter()

@end

@implementation BPRefreshFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    // 设置控件的高度
    self.mj_h = kRefreshFooterHeight;
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    self.stateLabel.hidden = NO; 
    self.stateLabel.textColor = [UIColor lightGrayColor];
    //self.loadingView.color = themeColor;

    [self setTitle:kFooterPullToRefreshText forState:MJRefreshStateIdle];
    [self setTitle:kFooterRefreshingText forState:MJRefreshStateRefreshing];
    [self setTitle:kFooterRefreshNoMoreDataText forState:MJRefreshStateNoMoreData];
}

@end
