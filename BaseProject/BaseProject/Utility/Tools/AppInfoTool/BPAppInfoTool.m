//
//  BPAppInfoTool.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/26.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAppInfoTool.h"
#import "SAMKeychain.h"

@implementation BPAppInfoTool

- (NSString *)uuid {
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:@"com.cactus.BaseProject"account:@"BaseProject"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""]) {
        NSUUID *currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        //currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        //currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SAMKeychain setPassword: currentDeviceUUIDStr forService:@"com.cactus.BaseProject"account:@"BaseProject"];
    }
    return currentDeviceUUIDStr;
}

@end
