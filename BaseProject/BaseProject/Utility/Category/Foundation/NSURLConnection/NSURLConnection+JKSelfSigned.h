//
//  NSURLConnection+SelfSigned.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

// A category on NSURLConnection that allows making async requests that accept all https certificates. 
//https://github.com/yuriy128/NSURLConnection-SelfSigned
#import <Foundation/Foundation.h>

@interface NSURLConnection (JKSelfSigned)
/**
 *
 *  Sends async request while accepting all self-signed certs
 *
 */
+ (void)_sendAsynchronousRequestAcceptingAllCerts:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(void (^)(NSURLResponse *, NSData *, NSError *))handler;

@end
