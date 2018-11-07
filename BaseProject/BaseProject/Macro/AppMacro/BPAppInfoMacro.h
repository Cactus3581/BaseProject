//
//  BPAppInfoMacro.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#ifndef BPAppInfoMacro_h
#define BPAppInfoMacro_h

//刷新加载控件文案
#define kRefreshHeaderHeight 64;
#define kRefreshFooterHeight 36;

#define kHeaderPullToRefreshText        @"下拉刷新"
#define kHeaderReleaseToRefreshText     @"松开刷新数据"
#define kHeaderRefreshingText           @"正在加载..."

#define kFooterPullToRefreshText        @"上拉加载更多"
#define kFooterReleaseToRefreshText     @"松开加载更多数据"
#define kFooterRefreshingText           @"正在载入..."
#define kFooterRefreshNoMoreDataText    @"没有更多内容了"

/*
 //系统版本号
 @property (strong, nonatomic,readonly) NSString *systemVersion;
 //设备唯一标识码
 @property (strong, nonatomic,readonly) NSString *uuid;
 //idfa(identifierForIdentifier，广告标示符)
 @property (strong, nonatomic, readonly) NSString *idfa;
 //app版本号
 @property (strong, nonatomic,readonly) NSString *clientVersion;
 //设备类型,iPhone,iPad
 @property (strong, nonatomic,readonly) NSString *mobileType;
 */

#endif /* BPAppInfoMacro_h */
