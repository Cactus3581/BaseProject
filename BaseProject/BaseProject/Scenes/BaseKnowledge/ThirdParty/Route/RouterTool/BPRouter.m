//
//  BPRouter.m
//  JSDRouterGuide
//
//  Created by ryan on 2020/2/19.
//  Copyright © 2019 Cactus. All rights reserved.
//

#import "BPRouter.h"

BOOL userIsLogin = NO;

@implementation BPRouter



// 触发跳转
+ (BOOL)openURL:(NSString *)url {
    return [self routeURL:url parameters:nil];
}

+ (BOOL)openURL:(NSString *)url parameters:(NSDictionary *)parameters {
   return [self routeURL:url parameters:parameters];
}

+ (BOOL)routeURL:(NSString *)url parameters:(NSDictionary *)parameters{
    return [JLRoutes routeURL:[NSURL URLWithString:url] withParameters:parameters];
}

@end
