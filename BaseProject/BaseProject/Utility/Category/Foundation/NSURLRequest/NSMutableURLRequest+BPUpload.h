//  NSMutableURLRequest+Upload.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (BPUpload)

/**
 *  生成单文件上传的 multipart/form-data 请求
 *
 *  @param URL     负责上传的 url
 *  @param fileURL 要上传的本地文件 url
 *  @param name    服务器脚本字段名
 *
 *  @return multipart/form-data POST 请求，保存到服务器的文件名与本地的文件名一致
 */
+ (instancetype)_requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL name:(NSString *)name;

/**
 *  生成单文件上传的 multipart/form-data 请求
 *
 *  @param URL      负责上传的 url
 *  @param fileURL  要上传的本地文件 url
 *  @param fileName 要保存在服务器上的文件名
 *  @param name     服务器脚本字段名
 *
 *  @return multipart/form-data POST 请求
 */
+ (instancetype)_requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL fileName:(NSString *)fileName name:(NSString *)name;

/**
 *  生成多文件上传的 multipart/form-data 请求
 *
 *  @param URL      负责上传的 url
 *  @param fileURLs 要上传的本地文件 url 数组
 *  @param name     服务器脚本字段名
 *
 *  @return multipart/form-data POST 请求，保存到服务器的文件名与本地的文件名一致
 */
+ (instancetype)_requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs name:(NSString *)name;

/**
 *  生成多文件上传的 multipart/form-data 请求
 *
 *  @param URL       负责上传的 url
 *  @param fileURLs  要上传的本地文件 url 数组
 *  @param fileNames 要保存在服务器上的文件名数组
 *  @param name      服务器脚本字段名
 *
 *  @return multipart/form-data POST 请求
 */
+ (instancetype)_requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs fileNames:(NSArray *)fileNames name:(NSString *)name;

@end
