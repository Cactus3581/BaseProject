//
//  BPNetTool.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPNetTool.h"
#import "BPAppMacro.h"
#import <AFNetworkReachabilityManager.h>
#import <AFNetworking.h>

static BPCacheTool *netCacheTool;
__attribute__((constructor))
static void BPStartMonitoringNetStatus(){
    NSLog(@"开启网络监听,初始化网络缓存工具");
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    netCacheTool = [BPCacheTool bp_cacheToolWithType:BPCacheToolTypeMemoryAndDisk name:@"BPNetCache"];
    netCacheTool.shouldRemoveAllObjectsOnMemoryWarning = YES;
    netCacheTool.shouldRemoveAllObjectsWhenEnteringBackground = NO;
}

@implementation BPNetTool{
    NSURLSessionDataTask *_lastTask;
    dispatch_semaphore_t _semaphore;
    AFHTTPSessionManager *_manager;
}

+ (BPCacheTool *)bp_netCacheTool{
    return netCacheTool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _semaphore = dispatch_semaphore_create(1);
        _timeoutInterval = 15;
    }
    return self;
}

+ (BPNetStatusType)bp_getNetStatus{
    return (BPNetStatusType)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (void)bp_get:(NSString *)url params:(NSDictionary *)params success:(BPNetConfig)success fail:(BPNetConfig)fail{
    if (!url.length) NSAssert(url.length, @"Argument: url不能为空");
    weakify(self);
    [self _bp_searchCache:url params:params success:success fail:^{
        strongify(self);
        [self _bp_get:url params:params success:success fail:fail];
    }];
}

- (void)bp_post:(NSString *)url params:(NSDictionary *)params success:(BPNetConfig)success fail:(BPNetConfig)fail{
    if (!url.length) NSAssert(url.length, @"Argument: url不能为空");
    weakify(self);
    [self _bp_searchCache:url params:params success:success fail:^{
        strongify(self);
        [self _bp_post:url params:params success:success fail:fail];
    }];
    
}

- (void)bp_soap:(NSString *)url soapXMLString:(NSString *)soap success:(BPNetConfig)success fail:(BPNetConfig)fail{
    if (!url.length) NSAssert(url.length, @"Argument: url不能为空");
    if (!url.length) NSAssert(soap.length, @"Argument: soapXMLString不能为空");
    weakify(self);
    [self _bp_searchCache:url params:@{@"soap" : soap} success:success fail:^{
        strongify(self);
        [self _bp_soap:url soapXMLString:soap success:success fail:fail];
    }];
    
}

- (void)_bp_get:(NSString *)url params:(NSDictionary *)params success:(BPNetConfig)success fail:(BPNetConfig)fail{
    if ([BPNetTool bp_getNetStatus] == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = nil;
        doBlock(fail, error);
        return;
    }
    [self _bp_mangerConfig];
    weakify(self);
    _lastTask = [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            strongify(self);
            [self _bp_saveCache:url params:params value:responseObject];
            doBlock(success, responseObject);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            doBlock(fail, error);
        });
    }];
    [_lastTask resume];
}

- (void)_bp_post:(NSString *)url params:(NSDictionary *)pramas success:(BPNetConfig)success fail:(BPNetConfig)fail{
    if ([BPNetTool bp_getNetStatus] == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = nil;
        if (fail) {
            fail(error);
        }
        return;
    }
    [self _bp_mangerConfig];
    _lastTask = [_manager POST:url parameters:pramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    [_lastTask resume];
}

- (void)_bp_soap:(NSString *)url soapXMLString:(nullable NSString *)soap success:(BPNetConfig)success fail:(BPNetConfig)fail {
    [self _bp_mangerConfig];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soap dataUsingEncoding:NSUTF8StringEncoding]];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _lastTask = [_manager dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:^( NSURLResponse *response, id responseObject, NSError *error){
                                if (error) {
                                    if (fail) {
                                        fail(error);
                                    }
                                }else{
                                    if (success) {
                                        success(responseObject);
                                    }
                                }
                            }];
    [_lastTask resume];
}

- (void)_bp_mangerConfig{
    //设置信号量，防止多线程修改请求参数，出现错误
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_needCancleLastRequest) {
        [_lastTask cancel];
    }
    if (_supportcontentType) {
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:_supportcontentType];
    }
    if (_supportTextHtml) {
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    if (_support3840) {
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    if (_requestHeader.count) {
        NSMutableDictionary *headers = [_manager.requestSerializer valueForKey:@"mutableHTTPRequestHeaders"];
        [headers removeObjectsForKeys:_requestHeader.allKeys];
        [headers addEntriesFromDictionary:_requestHeader];
    }
    _manager.requestSerializer.timeoutInterval = _timeoutInterval;
    dispatch_semaphore_signal(_semaphore);
}

- (BOOL)_bp_isNeedSearchCache{
    if (!netCacheTool) return NO;
    if (_cacheNetType == BPNetToolCacheTypeNone) return NO;
    BPNetStatusType netStatus = [BPNetTool bp_getNetStatus];
    switch (netStatus) {
        case BPNetStatusTypeUnKnown: {
            return NO;
        }
        case BPNetStatusTypNotReachable: {
            return YES;
        }
        case BPNetStatusTypeWWAN: {
            return _cacheNetType != BPNetToolCacheTypeWhenNetNotReachable;
        }
        case BPNetStatusTypeWIFI: {
            return _cacheNetType == BPNetToolCacheTypeAllNetStatus;
        }
    }
}

- (void)_bp_searchCache:(NSString *)url params:(NSDictionary *)params success:(BPNetConfig)success fail:(dispatch_block_t)fail{
    if (![self _bp_isNeedSearchCache]) {
        doBlock(fail);
        return;
    };
    NSString *key = [self _bp_getCacheKeyWithUrl:url params:params];
    if (!key.length) {
        doBlock(fail);
        return;
    }
    [netCacheTool bp_objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding> _Nullable object) {
        if (object) {
            doBlock(success, object);
        }else{
            doBlock(fail);
        }
    }];
}

- (void)_bp_saveCache:(NSString *)url params:(NSDictionary *)params value:(id)object{
    if (!object || !netCacheTool || _cacheNetType == BPNetToolCacheTypeNone) return;
    NSString *key = [self _bp_getCacheKeyWithUrl:url params:params];
    if (!key.length) return;
    [netCacheTool bp_setObject:object forKey:key];
}

- (NSString *)_bp_getCacheKeyWithUrl:(NSString *)url params:(NSDictionary *)params{
    NSMutableString *temp = url.mutableCopy;
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [temp appendString:key];
        [temp appendString:[NSString stringWithFormat:@"%@", obj]];
    }];
    return temp.copy;
}
@end

