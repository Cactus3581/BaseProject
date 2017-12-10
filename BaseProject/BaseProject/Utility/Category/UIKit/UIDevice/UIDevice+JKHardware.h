//
//  UIDevice+Hardware.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIDevice (JKHardware)
+ (NSString *)bp_platform;
+ (NSString *)bp_platformString;


+ (NSString *)bp_macAddress;

//Return the current device CPU frequency
+ (NSUInteger)bp_cpuFrequency;
// Return the current device BUS frequency
+ (NSUInteger)bp_busFrequency;
//current device RAM size
+ (NSUInteger)bp_ramSize;
//Return the current device CPU number
+ (NSUInteger)bp_cpuNumber;
//Return the current device total memory

/// 获取iOS系统的版本号
+ (NSString *)bp_systemVersion;
/// 判断当前系统是否有摄像头
+ (BOOL)bp_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)bp_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)bp_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)bp_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)bp_totalDiskSpaceBytes;
@end
