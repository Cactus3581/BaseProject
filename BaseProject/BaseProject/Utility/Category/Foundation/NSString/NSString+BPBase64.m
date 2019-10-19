//
//  NSString+BPBase64.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSString+BPBase64.h"
#import "NSData+BPBase64.h"

@implementation NSString (Base64)
+ (NSString *)_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData _dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data _base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data _base64EncodedString];
}
- (NSString *)_base64DecodedString
{
    return [NSString _stringWithBase64EncodedString:self];
}
- (NSData *)_base64DecodedData
{
    return [NSData _dataWithBase64EncodedString:self];
}
@end
