//
//  NSString+JKEncrypt.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
// 加密解密工具 http://tool.chacuo.net/cryptdes
#import "NSString+JKEncrypt.h"
#import "NSData+JKEncrypt.h"
#import "NSData+JKBase64.h"

@implementation NSString (JKEncrypt)
-(NSString*)jk_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] jk_encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted jk_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)jk_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData jk_dataWithBase64EncodedString:self] jk_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)jk_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] jk_encryptedWithDESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted jk_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)jk_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData jk_dataWithBase64EncodedString:self] jk_decryptedWithDESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)jk_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] jk_encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted jk_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)jk_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData jk_dataWithBase64EncodedString:self] jk_decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

@end
