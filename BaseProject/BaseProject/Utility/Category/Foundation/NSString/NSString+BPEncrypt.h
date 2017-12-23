//
//  NSString+BPEncrypt.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
// 加密解密工具 http://tool.chacuo.net/cryptdes

#import <Foundation/Foundation.h>

@interface NSString (BPEncrypt)
/**
 *  AES加密数据
 *
 *  @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  AES解密数据
 *
 *  @param key key 长度一般为16
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  DES加密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  DE解密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  3DES加密数据 
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  3DES解密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
