//
//  NSURLRequest+ParamsFromDictionary.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.

#import "NSURLRequest+BPParamsFromDictionary.h"

@implementation NSURLRequest (BPParamsFromDictionary)

+ (NSURLRequest *)_requestGETWithURL:(NSURL *)url parameters:(NSDictionary *)params {
    //This code is ARC only.
    return [[NSURLRequest alloc] initWithURL:url parameters:params];
}

- (instancetype)initWithURL:(NSURL *)URL parameters:(NSDictionary *)params {
    if (params) {
        NSArray *queryStringComponents = [[self class] _queryStringComponentsFromKey:nil value:params];
        NSString *parameterString = [queryStringComponents componentsJoinedByString:@"&"];
        if ([[URL absoluteString] rangeOfString:@"?"].location == NSNotFound) {
            URL = [NSURL URLWithString:[[URL absoluteString] stringByAppendingFormat:@"?%@",parameterString]];
        } else {
            URL = [NSURL URLWithString:[[URL absoluteString] stringByAppendingFormat:@"&%@",parameterString]];
        }
    }
    self = [self initWithURL:URL];
    if (!self) {
        return nil;
    }
    return self;
}

+ (NSString *)_URLfromParameters:(NSDictionary *)params{
    if (params) {
        NSArray *queryStringComponents = [[self class] _queryStringComponentsFromKey:nil value:params];
        NSString *parameterString = [queryStringComponents componentsJoinedByString:@"&"];
        return parameterString;
    }
    return @"";
}
//These next three methods recursively break the dictionary down into its components.  Largely based on AFHTTPClient, but somewhat more readable and understandable (by me, anyway).
+ (NSArray *)_queryStringComponentsFromKey:(NSString *)key value:(id)value {
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    if ([value isKindOfClass:[NSDictionary class]]) {
        [queryStringComponents addObjectsFromArray:[self _queryStringComponentsFromKey:key dictionaryValue:value]];
    } else if ([value isKindOfClass:[NSArray class]]) {
        [queryStringComponents addObjectsFromArray:[self _queryStringComponentsFromKey:key arrayValue:value]];
    } else {
        static NSString * const kLegalURLEscapedCharacters = @"?!@#$^&%*+=,:;'\"`<>()[]{}/\\|~ ";
        NSString *valueString = [value description];
        NSString *unescapedString = [valueString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (unescapedString) {
            valueString = unescapedString;
        }
        NSString *escapedValue = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge_retained CFStringRef)valueString, NULL, (__bridge_retained CFStringRef) kLegalURLEscapedCharacters, CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        
        NSString *component = [NSString stringWithFormat:@"%@=%@", key, escapedValue];
        [queryStringComponents addObject:component];
    }
    
    return queryStringComponents;
}

+ (NSArray *)_queryStringComponentsFromKey:(NSString *)key dictionaryValue:(NSDictionary *)dict{
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    [dict enumerateKeysAndObjectsUsingBlock:^(id nestedKey, id nestedValue, BOOL *stop) {
        NSArray *components = nil;
        if (key == nil) {
            components = [self _queryStringComponentsFromKey:nestedKey value:nestedValue];
        } else {
            components = [self _queryStringComponentsFromKey:[NSString stringWithFormat:@"%@[%@]", key, nestedKey] value:nestedValue];
        }
        
        [queryStringComponents addObjectsFromArray:components];
    }];
    
    return queryStringComponents;
}

+ (NSArray *)_queryStringComponentsFromKey:(NSString *)key arrayValue:(NSArray *)array{
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    [array enumerateObjectsUsingBlock:^(id nestedValue, NSUInteger index, BOOL *stop) {
        [queryStringComponents addObjectsFromArray:[self _queryStringComponentsFromKey:[NSString stringWithFormat:@"%@[]", key] value:nestedValue]];
    }];
    
    return queryStringComponents;
}



@end
