//
//  BPNetTool.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

//使用前请导入AFN框架
#import <Foundation/Foundation.h>
#import "BPCacheTool.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BPNetConfig)(id object);

typedef NS_ENUM(NSUInteger, BPNetStatusType) {
    BPNetStatusTypeUnKnown          = -1,
    BPNetStatusTypNotReachable      = 0,
    BPNetStatusTypeWWAN             = 1,
    BPNetStatusTypeWIFI             = 2,
};

typedef NS_ENUM(NSUInteger, BPNetToolCacheType) {
    BPNetToolCacheTypeNone = 0, //不进行接口缓存
    BPNetToolCacheTypeWhenNetNotReachable, //只在无网络的时候才读取缓存
    BPNetToolCacheTypeWhenCellNetOrNetNotReachable,//无网络和蜂窝网络都优先读取缓存
    BPNetToolCacheTypeAllNetStatus//所有情况下都优先读取缓存
};

@interface BPNetTool : NSObject

/**是否需要取消上一次的网络请求*/
@property (nonatomic, assign) BOOL needCancleLastRequest;
/**3840错误解决*/
@property (nonatomic, assign) BOOL support3840;
/**常见text/html不支持错误解决*/
@property (nonatomic, assign) BOOL supportTextHtml;
/**手动设置contentType*/
@property (nonatomic, copy) NSString *supportcontentType;
/**请求头*/
@property (nonatomic, copy) NSDictionary *requestHeader;
/**超时时间， 默认15秒*/
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/**读取缓存时机类型，默认无网络才会读取缓存数据，*/
@property (nonatomic, assign) BPNetToolCacheType cacheNetType;


+ (BPCacheTool *)bp_netCacheTool;

/**
 *  获取当前网络状态
 */
+ (BPNetStatusType)bp_getNetStatus;

/**
 *  get网络请求
 *
 *  @param url     请求地址
 *  @param pramas  参数
 */
- (void)bp_get:(NSString *)url params:(nullable NSDictionary *)params success:(BPNetConfig)success fail:(BPNetConfig)fail;


/**
 *  post网络请求
 *
 *  @param url     请求地址
 *  @param pramas  报文
 */
- (void)bp_post:(NSString *)url params:(nullable NSDictionary *)params success:(BPNetConfig)success fail:(BPNetConfig)fail;


/**
 *  soap post请求(需要传递xml参数，该方法无需设置supportTextHtml和support3840属性)
 *
 *  @param url     请求地址
 *  @param soap    xml字符串参数
 */
- (void)bp_soap:(NSString *)url soapXMLString:(nullable NSString *)soap success:(BPNetConfig)success fail:(BPNetConfig)fail;


@end

NS_ASSUME_NONNULL_END

