//
//  BPBaseServerAPI.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseServerAPI.h"
#import "YTKNetworkConfig.h"

@implementation BPBaseServerAPI

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - 修改 YTKNetworkConfig 中的 baseUrl
- (void)configHosts {
     YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
     config.baseUrl = @"";
}

#pragma mark - 只填除去域名剩余的网址信息
- (NSString *)requestUrl {
    return @"";
}

#pragma mark - 指定请求方法
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

#pragma mark - 参数
- (id)requestArgument {
    return @{};
}

@end
