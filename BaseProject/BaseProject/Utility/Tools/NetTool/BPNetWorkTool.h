//
//  BPNetWorkTool.h
//  BaseProject
//
//  Created by Ryan on 2017/11/16.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BPRequestMethod) {
    BPRequestGet ,//默认请求方式为get
    BPRequestPost
};

//typedef void (^successBlock) (NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
//typedef void (^failureBlock) (NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

typedef void (^successBlock) (NSDictionary *_Nullable responseObject);
typedef void (^failureBlock) (NSError * error);

@interface BPRequest : NSObject
@property (nonatomic,assign) BPRequestMethod method;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) NSDictionary *parms;
@property (nonatomic,strong) NSDictionary *response;
@property (nonatomic, copy, nullable) void (^successCompletionBlock)(BPRequest *);
@property (nonatomic, copy, nullable) void (^failureCompletionBlock)(BPRequest *);

- (void)requestWithSuccess:(void (^)(BPRequest *request))success failure:(void (^)(BPRequest *request))failure;
@end

@interface BPBatchRequest : NSObject
@property (nonatomic,strong) NSArray *batchRequest;
@property (nonatomic, copy, nullable) void (^successCompletionBlock)(BPBatchRequest *);
@property (nonatomic, copy, nullable) void (^failureCompletionBlock)(BPBatchRequest *);
- (void)requestWithCompletionBlockWithSuccess:(void (^)(BPBatchRequest *batchRequest))success
                                      failure:(void (^)(BPBatchRequest *batchRequest))failure;
@end

@interface BPNetWorkTool : NSObject
@property (nonatomic,assign) BPRequestMethod method;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)shareNetwork;
- (void)requestWithMethod:(BPRequestMethod)method urlString:(NSString *)string parms:(NSDictionary *)obj success:(successBlock)success failure:(failureBlock)fail;
@end

NS_ASSUME_NONNULL_END
