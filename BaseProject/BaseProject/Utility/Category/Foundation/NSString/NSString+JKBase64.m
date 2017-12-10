//
//  NSString+JKBase64.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSString+JKBase64.h"
#import "NSData+JKBase64.h"

@implementation NSString (Base64)
+ (NSString *)jk_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData jk_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)jk_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data jk_base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)jk_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data jk_base64EncodedString];
}
- (NSString *)jk_base64DecodedString
{
    return [NSString jk_stringWithBase64EncodedString:self];
}
- (NSData *)jk_base64DecodedData
{
    return [NSData jk_dataWithBase64EncodedString:self];
}
@end
