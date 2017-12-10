//
//  UIApplication+JKNetworkActivityIndicator.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIApplication+JKNetworkActivityIndicator.h"

#import <libkern/OSAtomic.h>

@implementation UIApplication (JKNetworkActivityIndicator)

static volatile int32_t numberOfActiveNetworkConnectionsxxx;

#pragma mark Public API

- (void)bp_beganNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

- (void)bp_endedNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(-1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

@end
