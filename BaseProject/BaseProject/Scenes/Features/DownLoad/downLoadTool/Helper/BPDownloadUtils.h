//
//  BPDownloadUtils.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/5.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPDownloadUtils : NSObject

/**
 获取当前手机的空闲磁盘空间
 */
+ (NSUInteger)fileSystemFreeSize;

/**
 将文件的字节大小，转换成更加容易识别的大小KB，MB，GB
 */
+ (NSString *)fileSizeStringFromBytes:(NSUInteger)byteSize;

/**
 字符串md5加密
 
 @param string 需要MD5加密的字符串
 @return MD5后的值
 */
+ (NSString *)md5ForString:(NSString *)string;

/**
 创建路径
 */
+ (BOOL)createPathIfNotExist:(NSString *)path;

@end
