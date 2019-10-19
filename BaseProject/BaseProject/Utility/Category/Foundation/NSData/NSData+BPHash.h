//
//  NSData+BPHash.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BPHash)
/**
 *  @brief  md5 NSData
 */
@property (readonly) NSData *_md5Data;
/**
 *  @brief  sha1Data NSData
 */
@property (readonly) NSData *_sha1Data;
/**
 *  @brief  sha256Data NSData
 */
@property (readonly) NSData *_sha256Data;
/**
 *  @brief  sha512Data NSData
 */
@property (readonly) NSData *_sha512Data;

/**
 *  @brief  md5 NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)_hmacMD5DataWithKey:(NSData *)key;
/**
 *  @brief  sha1Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)_hmacSHA1DataWithKey:(NSData *)key;
/**
 *  @brief  sha256Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)_hmacSHA256DataWithKey:(NSData *)key;
/**
 *  @brief  sha512Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)_hmacSHA512DataWithKey:(NSData *)key;
@end
