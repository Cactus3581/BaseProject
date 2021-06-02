//
//  BPRouter.h
//  JSDRouterGuide
//
//  Created by ryan on 2020/2/19.
//  Copyright © 2019 Cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JLRoutes/JLRoutes.h>
#import "BPRouterConfig.h"
#import "UIViewController+BPAdd.h"

extern BOOL userIsLogin;
NS_ASSUME_NONNULL_BEGIN

@interface BPRouter : NSObject

// 注册 Router,调用 Router 时会触发回调;
//+ (void)addRoute:(NSString *)route handler:(BOOL (^)(NSDictionary *parameters))handlerBlock;

// 触发跳转
+ (BOOL)openURL:(NSString *)url;
+ (BOOL)openURL:(NSString *)url parameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
