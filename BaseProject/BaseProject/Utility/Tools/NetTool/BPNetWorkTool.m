//
//  BPNetWorkTool.m
//  BaseProject
//
//  Created by Ryan on 2017/11/16.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPNetWorkTool.h"
#import "MJExtension.h"
#import "NSObject+MJKeyValue.h"

@interface BPNetWorkTool()

@end

static BPNetWorkTool *netWorkTool = nil;

@implementation BPNetWorkTool
#pragma mark - 初始化Network
+ (instancetype)shareNetwork {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkTool = [[self alloc]init];
    });
    return netWorkTool;
}

- (BPRequestMethod)method {
    if (!_method) {
        _method = BPRequestGet;
    }
    return _method;
}

#pragma mark - 封堵alloc及copy
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(netWorkTool == nil) {
            netWorkTool = [super allocWithZone:zone];
        }
    });
    return netWorkTool;
}

//保证copy时相同
- (instancetype)copyWithZone:(NSZone *)zone {
    return netWorkTool;
}

//请求数据
- (void)requestWithMethod:(BPRequestMethod)method urlString:(NSString *)url parms:(NSDictionary *)parms success:(successBlock)success failure:(failureBlock)fail {
    self.method = method;
//    id model;
//    NSMutableDictionary *dic = model.mj_keyValues;
//    if (BPValidateDict(parms).allKeys.count) {
//        [dic addEntriesFromDictionary:parms];
//    }
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    if (self.method == BPRequestGet) {
        //[httpManager GET:string parameters:params progress:nil success:success failure:fail];
    }else if (self.method == BPRequestPost) {
        //[httpManager POST:string parameters:params progress:nil success:success failure:fail];
    }
    
    //TODO:替换
    /*
    [BPHttpRequest getWithURL:url params:dic.copy progress:nil success:^(id json) {
        if([BPValidateString(BPValidateDict(json)[@"status"]) isEqualToString:@"1"]) {
            success(json);
        } else {
            NSError *error = [NSError mj_error];
            fail(error);
        }
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        fail(error);
    }];
     */
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

@end


@implementation BPRequest

- (void)requestWithSuccess:(void (^)(BPRequest *request))success failure:(void (^)(BPRequest *request))failure {
    [[BPNetWorkTool shareNetwork] requestWithMethod:self.method urlString:self.url parms:self.parms success:^(NSDictionary * _Nullable responseObject) {
        self.response = responseObject;
        success(self);
    } failure:^(NSError * _Nonnull error) {
        self.response = @{};
        failure(self);
    }];
}
@end

@implementation BPBatchRequest

- (void)requestWithCompletionBlockWithSuccess:(void (^)(BPBatchRequest *batchRequest))success
                                    failure:(void (^)(BPBatchRequest *batchRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(BPBatchRequest *batchRequest))success
                              failure:(void (^)(BPBatchRequest *batchRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}
    
- (void)start {
    dispatch_group_t group = dispatch_group_create();
    for (BPRequest * req in self.batchRequest) {
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self requestWithReq:req];
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([self handleReq]) {
            self.successCompletionBlock(self);
        }else {
            self.failureCompletionBlock(self);
        }
    });
}

- (void)requestWithReq:(BPRequest *)req {
    [req requestWithSuccess:^(BPRequest * _Nonnull request) {
        
    } failure:^(BPRequest * _Nonnull request) {
        
    }];
}

- (BOOL)handleReq {
    __block BOOL result = true;
    [self.batchRequest enumerateObjectsUsingBlock:^(BPRequest *req, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!req.response.allKeys.count) {
            *stop = YES;
            result = false;
        }
    }];
    return result;
}

@end
