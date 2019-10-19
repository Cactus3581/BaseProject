//
//  NSData+BPAdd.h
//  BaseProject
//
//  Created by Ryan on 16/5/13.
//  Copyright © 2016年 cactus. All rights reserved.
//  使用前请添加libz.tbd

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (BPAdd)

@property (nonatomic, readonly) NSString *md2String;
@property (nonatomic, readonly) NSString *md4String;
@property (nonatomic, readonly) NSString *md5String;
@property (nonatomic, readonly) NSString *sha1String;
@property (nonatomic, readonly) NSString *sha224String;
@property (nonatomic, readonly) NSString *sha256String;
@property (nonatomic, readonly) NSString *sha384String;
@property (nonatomic, readonly) NSString *sha512String;

@property (nonatomic, readonly) NSData *md2Data;
@property (nonatomic, readonly) NSData *md4Data;
@property (nonatomic, readonly) NSData *md5Data;
@property (nonatomic, readonly) NSData *sha1Data;
@property (nonatomic, readonly) NSData *sha224Data;
@property (nonatomic, readonly) NSData *sha256Data;
@property (nonatomic, readonly) NSData *sha384Data;
@property (nonatomic, readonly) NSData *sha512Data;

@property (nonatomic, readonly) NSString *crc32String;
@property (nonatomic, readonly) uint32_t crc32;

/** note for hmac:HMAC是密钥相关的哈希运算消息认证码（Hash-based Message Authentication Code）,HMAC运算利用哈希算法，以一个密钥和一个消息为输入，生成一个消息摘要作为输出。*/

#pragma mark - hmac (HMAC 加密相关，通过一个Key值进行加密)

- (NSString *)bp_hmacMD5StringWithKey:(NSString *)key;

- (NSData *)bp_hmacMD5DataWithKey:(NSData *)key;

- (NSString *)bp_hmacSHA1StringWithKey:(NSString *)key;

- (NSData *)bp_hmacSHA1DataWithKey:(NSData *)key;

- (NSString *)bp_hmacSHA224StringWithKey:(NSString *)key;

- (NSData *)bp_hmacSHA224DataWithKey:(NSData *)key;

- (NSString *)bp_hmacSHA256StringWithKey:(NSString *)key;

- (NSData *)bp_hmacSHA256DataWithKey:(NSData *)key;

- (NSString *)bp_hmacSHA384StringWithKey:(NSString *)key;

- (NSData *)bp_hmacSHA384DataWithKey:(NSData *)key;

- (NSString *)bp_hmacSHA512StringWithKey:(NSString *)key;

- (NSData *)bp_hmacSHA512DataWithKey:(NSData *)key;

#pragma mark - aes256 (AES-256 加密相关)

/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (NSData *)bp_aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (NSData *)bp_aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;

#pragma mark - encode and decode (编码或者解码相关)

@property (nonatomic, readonly) NSString *utf8String;
@property (nonatomic, readonly) NSString *hexString;
@property (nonatomic, readonly) NSString *base64EncodedString;
/**将data转成JSON数组或者字典*/
@property (nonatomic, readonly) id jsonValue;

+ (NSData *)bp_dataWithHexString:(NSString *)hexString;
+ (NSData *)bp_dataWithBase64EncodedString:(NSString *)base64EncodedString;

#pragma mark - comperss and decompress(数据压缩或者解压缩相关)

/** note : gzip 和 zlib 都是两种数据压缩算法*/

/**
 Decompress data from gzip data.
 */
- (NSData *)bp_gzipDecompress;

/**
 Comperss data to gzip in default compresssion level.
 */
- (NSData *)bp_gzipComperss;

/**
 Decompress data from zlib-compressed data.
 */
- (NSData *)bp_zlibDecompress;

/**
 Comperss data to zlib-compressed in default compresssion level.
 */
- (NSData *)bp_zlibComperss;

#pragma mark - other

/**加载main bundle 对应文件名的数据并转成NSData，类似于[UIImage imageNamed:]*/
+ (NSData *)bp_dataNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
