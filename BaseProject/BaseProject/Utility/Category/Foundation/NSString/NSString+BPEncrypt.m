//
//  NSString+BPEncrypt.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
// 加密解密工具 http://tool.chacuo.net/cryptdes
#import "NSString+BPEncrypt.h"
#import "NSData+BPEncrypt.h"
#import "NSData+BPBase64.h"

@implementation NSString (BPEncrypt)
-(NSString*)_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] _encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted _base64EncodedString];
    
    return encryptedString;
}

- (NSString*)_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData _dataWithBase64EncodedString:self] _decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] _encryptedWithDESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted _base64EncodedString];
    
    return encryptedString;
}

- (NSString*)_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData _dataWithBase64EncodedString:self] _decryptedWithDESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] _encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted _base64EncodedString];
    
    return encryptedString;
}

- (NSString*)_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData _dataWithBase64EncodedString:self] _decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

@end
