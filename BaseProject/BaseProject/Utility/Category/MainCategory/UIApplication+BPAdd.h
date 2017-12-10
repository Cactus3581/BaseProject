//
//  UIApplication+BPAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (BPAdd)


#pragma mark - folder path

@property (nonatomic, readonly) NSURL *documentsURL;
@property (nonatomic, readonly) NSString *documentsPath;

@property (nonatomic, readonly) NSURL *cachesURL;
@property (nonatomic, readonly) NSString *cachesPath;

@property (nonatomic, readonly) NSURL *libraryURL;
@property (nonatomic, readonly) NSString *libraryPath;

#pragma mark - appInfo

@property (nullable, nonatomic, readonly) NSString *appBundleName;
@property (nullable, nonatomic, readonly) NSString *appBundleID;
@property (nullable, nonatomic, readonly) NSString *appVersion;
@property (nullable, nonatomic, readonly) NSString *appBuildVersion;
/**是否破解，未从app store 下载，但不能完全保证正确性，*/
@property (nonatomic, readonly) BOOL isPirated;
@property (nonatomic, readonly) BOOL isBeingDebugged;
@property (nonatomic, readonly) int64_t memoryUsage;
@property (nonatomic, readonly) float cpuUsage;

@end

NS_ASSUME_NONNULL_END
