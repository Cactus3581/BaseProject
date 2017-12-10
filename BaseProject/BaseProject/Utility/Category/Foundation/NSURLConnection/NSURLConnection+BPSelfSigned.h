//
//  NSURLConnection+SelfSigned.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnection (BPSelfSigned)
/**
 *
 *  Sends async request while accepting all self-signed certs
 *
 */
+ (void)_sendAsynchronousRequestAcceptingAllCerts:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(void (^)(NSURLResponse *, NSData *, NSError *))handler;

@end
