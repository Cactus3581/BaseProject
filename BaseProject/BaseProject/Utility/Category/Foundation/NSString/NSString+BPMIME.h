//
//  NSString+BPMIME.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BPMIME)
/**
 *  @brief  根据文件url 返回对应的MIMEType
 *
 *  @return MIMEType
 */
- (NSString *)_MIMEType;
/**
 *  @brief  根据文件url后缀 返回对应的MIMEType
 *
 *  @return MIMEType
 */
+ (NSString *)_MIMETypeForExtension:(NSString *)extension;
/**
 *  @brief  常见MIME集合
 *
 *  @return 常见MIME集合
 */
+ (NSDictionary *)_MIMEDict;
@end
