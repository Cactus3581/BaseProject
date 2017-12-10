//
//  NSDictionary+BPXML.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BPXML)
/**
 *  @brief  将NSDictionary转换成XML字符串 不带XML声明 不带根节点
 *
 *  @return XML 字符串
 */
- (NSString *)_XMLString;
/**
 *  @brief  将NSDictionary转换成XML字符串, 默认 <?xml version=\"1.0\" encoding=\"utf-8\"?> 声明   自定义根节点
 *
 *  @param rootElement 根节点
 *
 *  @return XML 字符串
 */
- (NSString *)_XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement;
/**
 *  @brief  将NSDictionary转换成XML字符串, 自定义根节点  自定义xml声明
 *
 *  @param rootElement 根节点
 *
 *  @param declaration xml声明
 *
 *  @return 标准合法 XML 字符串
 */
- (NSString *)_XMLStringWithRootElement:(NSString*)rootElement declaration:(NSString*)declaration;
/**
 *  @brief  将NSDictionary转换成Plist字符串
 *
 *  @return Plist 字符串
 */
- (NSString *)_plistString;
/**
 *  @brief  将NSDictionary转换成Plist data
 *
 *  @return Plist data
 */
- (NSData *)_plistData;

@end
