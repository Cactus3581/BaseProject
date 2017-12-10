//
//  BPDataTool.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/5/25.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSInteger second = 3600;

NS_ASSUME_NONNULL_BEGIN

/**
 判断是否为字符串
 
 @return 字符串
 */
static inline NSString * BPValidateString(NSString *rawString) {
    if (!rawString || [rawString isKindOfClass: [NSNull class]]) {
        return @"";
    }
    if (![rawString isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@", rawString];
    }
    return rawString;
};

static inline NSString * BPJSON(id theData) {
    if (!theData) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData && error == nil) {
        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return BPValidateString(jsonStr);
    }
    return @"";
}


/**
 判断是否为字典
 
 @return 字典
 */
static inline NSDictionary * BPValidateDict(NSDictionary *rawDict) {
    if (![rawDict isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    return rawDict;
};

/**
 判断是否为数组
 
 @return 数组
 */
static inline NSArray * BPValidateArray(NSArray *rawArray) {
    if (![rawArray isKindOfClass:[NSArray class]]) {
        return @[];
    }
    return rawArray;
};

static inline NSMutableArray * BPValidateMuArray(NSMutableArray *rawArray) {
    if (![rawArray isKindOfClass:[NSMutableArray class]]) {
        return @[].mutableCopy;
    }
    return rawArray;
};

/**
 判断是否越界
 
 @return id|nil
 */
static inline id BPValidateArrayObjAtIdx(NSArray * rawArray, NSUInteger idx) {
    if (![rawArray isKindOfClass:[NSArray class]] || !rawArray.count) {
        return nil;
    }
    return idx > rawArray.count - 1 ? nil : rawArray[idx];
};

static inline id BPValidateMuArrayObjAtIdx(NSMutableArray * rawArray, NSUInteger idx) {
    if (![rawArray isKindOfClass:[NSMutableArray class]] || !rawArray.count) {
        return nil;
    }
    return idx > rawArray.count - 1 ? nil : rawArray[idx];
};

/**
 判断是否为NSNumber
 
 @return NSNumber
 */
static inline NSNumber * BPValidateNumber(NSNumber *rawNumber) {
    if ([rawNumber isKindOfClass:[NSNumber class]]) {
        return rawNumber;
    }
    if ([rawNumber isKindOfClass:[NSString class]]) {
        id result;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        result=[formatter numberFromString:(NSString *)rawNumber];
        if(!(result)) {
            result=@0;
        }
        return result;
    }
    return @0;
};


/**
 判断是否为数组
 
 @return 数组
 */
static inline id BPValidateID(id obj) {
    if (obj) {
        return obj;
    }
    return @"";
};

static inline NSString * BPTimeString(NSInteger seconds) {
    if (seconds >= second) {
        //传入秒 返回:xx:xx:xx
        NSInteger hour = seconds/second;
        NSInteger minute = (seconds % second) / 60;
        NSInteger second = seconds % 60 ;
        return  [NSString stringWithFormat:@"%02td:%02td:%02td",hour,minute,second];
    }
    //传入秒,返回xx:xx
    NSInteger minute = seconds / 60;
    NSInteger second = (NSInteger)seconds % 60;
    return  [NSString stringWithFormat:@"%02td:%02td",minute,second];
};

NS_ASSUME_NONNULL_END


