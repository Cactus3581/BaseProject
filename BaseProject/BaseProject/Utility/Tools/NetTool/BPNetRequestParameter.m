//
//  BPNetRequestParameter.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNetRequestParameter.h"
#import "SAMKeychain.h"

@implementation BPNetRequestParameter

- (NSString *)uuid {
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:@"com.cactus.BaseProject"account:@"BaseProject"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""]) {
        NSUUID *currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        [SAMKeychain setPassword: currentDeviceUUIDStr forService:@"com.cactus.BaseProject"account:@"BaseProject"];
    }
    return currentDeviceUUIDStr;
}

@end
