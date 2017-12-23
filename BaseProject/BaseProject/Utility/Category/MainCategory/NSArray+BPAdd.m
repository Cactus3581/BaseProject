//
//  NSArray+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 16/5/13.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "NSArray+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(NSArray_BPAdd)

@implementation NSArray (BPAdd)


- (id)bp_randomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)bp_objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
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

- (NSArray *)bp_arrayAfterRandom {
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self];
    for (NSUInteger i = temp.count; i > 1; i--) {
        [temp exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
    return temp.copy;
}


+ (NSArray *)bp_arrayFromPlist:(NSString *)plistName{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
}
@end
