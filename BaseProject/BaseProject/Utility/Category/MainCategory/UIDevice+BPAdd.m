//
//  UIDevice+BPAdd.m
//  BPCurrencyExchange
//
//  Created by YouLoft_MacMini on 16/2/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIDevice+BPAdd.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <mach/mach.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#import <AdSupport/AdSupport.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UIDevice_BPAdd)

@implementation UIDevice (BPAdd)

- (NSString *)idfa{
    static NSString *idfa;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        idfa = idfa.length ? idfa : @"NULL";
    });
    return idfa;
    
}

- (NSString *)uuid{
    static NSString *uuid;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        uuid = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        uuid = uuid.length ? uuid : @"NULL";
    });
    return uuid;
    
}

- (BOOL)isPad{
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
- (BOOL)canMakePhoneCalls {
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}
#endif

- (BOOL)hasCamera
{
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    });
    return can;
}

- (NSString *)ipAddressWIFI {
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr != NULL) {
            if (addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:
                               inet_ntoa(((struct sockaddr_in *)addr->ifa_addr)->sin_addr)];
                    break;
                }
            }
            addr = addr->ifa_next;
        }
    }
    
    address = address.length ? address : @"NULL";
    freeifaddrs(addrs);
    return address;
}

- (NSString *)ipAddressCell {
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr != NULL) {
            if (addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
                    address = [NSString stringWithUTF8String:
                               inet_ntoa(((struct sockaddr_in *)addr->ifa_addr)->sin_addr)];
                    break;
                }
            }
            addr = addr->ifa_next;
        }
    }
    address = address.length ? address : @"NULL";
    freeifaddrs(addrs);
    return address;
}

- (NSString *)modelInfo{
    static dispatch_once_t one;
    static NSString *modelInfo;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        modelInfo = [NSString stringWithUTF8String:machine];
        modelInfo = modelInfo.length ? modelInfo : @"NULL";
        free(machine);
    });
    return modelInfo;
    
}

- (NSString *)modelInfoName{
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self modelInfo];
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"Apple Watch",
                              @"Watch1,2" : @"Apple Watch",
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (GSM)",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5",
                              @"iPhone5,2" : @"iPhone 5",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad2,5" : @"iPad mini 1",
                              @"iPad2,6" : @"iPad mini 1",
                              @"iPad2,7" : @"iPad mini 1",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (4G)",
                              @"iPad3,3" : @"iPad 3 (4G)",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad4,4" : @"iPad mini 2",
                              @"iPad4,5" : @"iPad mini 2",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3",
                              @"iPad4,8" : @"iPad mini 3",
                              @"iPad4,9" : @"iPad mini 3",
                              @"iPad5,1" : @"iPad mini 4",
                              @"iPad5,2" : @"iPad mini 4",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
        name = name.length ? name : @"NULL";
    });
    return name;
    
}

- (int64_t)diskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)diskSpaceFree {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)diskSpaceUsed {
    int64_t total = self.diskSpace;
    int64_t free = self.diskSpaceFree;
    if (total < 0 || free < 0) return -1;
    int64_t used = total - free;
    if (used < 0) used = -1;
    return used;
}

- (int64_t)memoryTotal {
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    if (mem < -1) mem = -1;
    return mem;
}

- (double)systemVersionValue{
    static double version = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [[UIDevice currentDevice].systemVersion doubleValue];
    });
    return version;
}

- (NSUInteger)cpuNumber {
    return [self getSysInfo:3];
}

- (BOOL)isSimulator {
    static dispatch_once_t one;
    static BOOL simu;
    dispatch_once(&one, ^{
        simu = NSNotFound != [[self model] rangeOfString:@"Simulator"].location;
    });
    return simu;
}

- (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (NSDictionary *)bp_getAllDeviceInfo{
    UIDevice *device = [UIDevice currentDevice];
    return @{@"systemVersion" : [NSString stringWithFormat:@"%@", device.systemVersion],
             @"idfa" : device.idfa,
             @"uuid" : device.uuid,
             @"isPad" : [NSString stringWithFormat:@"%zd",device.isPad],
             @"canMakePhoneCalls" : [NSString stringWithFormat:@"%zd",device.canMakePhoneCalls],
             @"modelInfo" : device.modelInfo,
             @"modelInfoName" : device.modelInfoName,
             @"ipAddressWIFI" : device.ipAddressWIFI,
             @"ipAddressCell" : device.ipAddressCell,
             @"diskSpace" : [NSString stringWithFormat:@"%lld", device.diskSpace],
             @"diskSpaceFree" : [NSString stringWithFormat:@"%lld", device.diskSpaceFree],
             @"diskSpaceUsed" : [NSString stringWithFormat:@"%lld", device.diskSpaceUsed],
             @"memoryTotal" : [NSString stringWithFormat:@"%lld", device.memoryTotal],
             @"hasCamera" : [NSString stringWithFormat:@"%zd",device.hasCamera],
             @"cpuNumber" :[NSString stringWithFormat:@"%zd", device.cpuNumber],};
}

+ (void)bp_openSystemAddressSettingPage{
    if ([UIDevice currentDevice].systemVersionValue >= 8.0 ) {
        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]){
            [[UIApplication sharedApplication] openURL:url];
        }
    }else{
        NSURL*url=[NSURL URLWithString:@"prefs:root=PRIVACY"];
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (NSString *)moblieOperatorName {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    if (res1 && res4) {
        return @"中国电信";
    }else if (res1 && res3){
        return @"中国联通";
    }else if (res1 && res2){
        return @"中国移动";
    }
    return @"其它号码";
}

- (BOOL)allowLocation{
    return [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
}

- (BOOL)allowNotification{
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        return YES;
    }
#else
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        return YES;
    }
#endif
    return NO;
}

+ (void)bp_openSystemNotificationSettingPageWithCompleteHandle:(void(^)(BOOL isAllowed))completeBlock {
    if ([UIDevice currentDevice].systemVersionValue >= 8.0 ) {
        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]){
            [[UIApplication sharedApplication] openURL:url];
        }
    }else{
        NSURL*url=[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"];
        [[UIApplication sharedApplication] openURL:url];
    }
    if (!completeBlock) {
        return;
    }
    objc_setAssociatedObject(self, "openSystemNotificationSettingPage", completeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_bp_setNotifcationAllowed) name:UIApplicationWillEnterForegroundNotification object:nil];
}

#pragma mark - private methods

+ (void)_bp_setNotifcationAllowed{
    void(^completeBlock)(BOOL isAllowed) = objc_getAssociatedObject(self, "openSystemNotificationSettingPage");
    if (!completeBlock) return;
    completeBlock ([UIDevice currentDevice].allowLocation);
    completeBlock = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

@end
