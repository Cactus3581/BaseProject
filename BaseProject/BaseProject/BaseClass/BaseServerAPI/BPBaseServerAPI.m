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

#pragma mark - 验证返回来的json的合法性
- (id)jsonValidator {
    //    return @{
    //             @"message": [NSArray class],
    //             };
    
    return @{
             @"message": @[@{
                               @"imageUrl": [NSString class],
                               @"moduleName": [NSString class],
                               @"moduleType": [NSString class],
                               @"position": [NSNumber class],
                               @"subModuleName": [NSString class]
                               }],
             //            @"status": [NSNumber class],
             };
}

#pragma mark - 按时间缓存内容,时间之内，不再请求
- (NSInteger)cacheTimeInSeconds {
    // 3 分钟 = 180 秒
    return 60 * 3;
}

@end
