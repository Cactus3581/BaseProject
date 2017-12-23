//
//  UIDevice+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 16/2/25.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (BPAdd)

#pragma mark - device info (设备信息相关)

@property (nonatomic,readonly) NSString *idfa;

@property (nonatomic,readonly) NSString *uuid;

@property (nonatomic, readonly) BOOL isPad;

@property (nonatomic, readonly) BOOL isSimulator;

@property (nonatomic, readonly) BOOL hasCamera;

@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

@property (nonatomic, readonly) NSUInteger cpuNumber;

//8.0,9.1
@property (nonatomic, readonly) double systemVersionValue;

//"iPhone9,2"
@property (nonatomic, readonly) NSString *modelInfo;

//"iPhone 5s"
@property (nonatomic, readonly) NSString *modelInfoName;

//"中国移动"
@property (nonatomic, readonly) NSString *moblieOperatorName;

//@"192.168.1.111，wifi的IP"
@property (nonatomic, readonly) NSString *ipAddressWIFI;

//@"10.2.2.222,蜂窝移动网络IP"
@property (nonatomic, readonly) NSString *ipAddressCell;

@property (nonatomic, readonly) int64_t diskSpace;

@property (nonatomic, readonly) int64_t diskSpaceFree;

@property (nonatomic, readonly) int64_t diskSpaceUsed;

@property (nonatomic, readonly) int64_t memoryTotal;

#pragma mark - check Allow (判断系统行为是否允许，通知定位等)

@property (nonatomic, readonly) BOOL allowNotification;

@property (nonatomic, readonly) BOOL allowLocation;

#pragma mark - open setting (打开系统设置界面)

/**
 *  打开系统通知界面, iOS7 需要添加一个名为prefs的URL Schemes
 *
 *  @param completeBlock 回到app后的回调
 */
+ (void)bp_openSystemNotificationSettingPageWithCompleteHandle:(void(^)(BOOL isAllowed))completeBlock;

/**打开定位设置界面*/
+ (void)bp_openSystemAddressSettingPage;

+ (NSDictionary *)bp_getAllDeviceInfo;

@end

NS_ASSUME_NONNULL_END
