//
//  NSString+JKBase64.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKBase64)
+ (NSString *)jk_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)jk_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)jk_base64EncodedString;
- (NSString *)jk_base64DecodedString;
- (NSData *)jk_base64DecodedData;
@end
