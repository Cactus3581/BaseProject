

//
//  NSDictionary+BPAdd.m
//  CatergoryDemo
//
//  Created by xiaruzhen on 16/5/13.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "NSDictionary+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(NSDictionary_BPAdd)

@implementation NSDictionary (BPAdd)


- (BOOL)bp_containsObjectForKey:(id)key {
    if (!key) return NO;
    return self[key] != nil;
}

- (NSString *)bp_jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSString *)bp_jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSDictionary *)bp_entriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) dic[key] = value;
    }
    return dic;
}

- (NSDictionary *)bp_dictionaryFromPlist:(NSString *)plistName{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
}
@end
