//
//  NSString+BPBase64.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BPBase64)
+ (NSString *)_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)_base64EncodedString;
- (NSString *)_base64DecodedString;
- (NSData *)_base64DecodedData;
@end
