//
//  NSString+BPSearchString.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/21.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "NSString+BPSearchString.h"

@implementation NSString (BPSearchString)

+ (NSAttributedString *)handleColorString:(NSString *)mainString childString:(NSString *)childString color:(UIColor *) themeColor {
    NSArray *array = [self handleStartLocationWithMainString:mainString childString:childString];
    NSArray *rangeArray = [self handleAllRangesWithLocations:array childString:childString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:mainString];
    [rangeArray enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [obj rangeValue];
        [attributedString addAttribute:NSForegroundColorAttributeName value:themeColor range:range];
        
    }];
    return attributedString.copy;
}

+ (NSArray <NSValue *> *)handleAllRangesWithLocations:(NSArray *)array childString:(NSString *)childString {
    NSInteger length = childString.length;
    NSMutableArray *muArray = @[].mutableCopy;
    [array enumerateObjectsUsingBlock:^(NSNumber *loc, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = NSMakeRange(loc.integerValue, length);
        [muArray addObject:[NSValue valueWithRange:range]];
    }];
    return muArray.copy;
}

/**
 查找子字符串在父字符串中的所有位置
 
 @param mainString 父字符串
 @param childString 子字符串
 @return 返回起始位置数组
 */
+ (NSArray *)handleStartLocationWithMainString:(NSString *)mainString childString:(NSString *)childString {
    NSRange range = [mainString rangeOfString:childString];
    NSMutableArray *locationMuArray = @[].mutableCopy;
    if (range.location == NSNotFound){
        return locationMuArray;
    }
    NSInteger recordStartLoc = -1;
    NSString *substring = mainString;//记录每次截取之后的字符串
    while (range.location != NSNotFound) {
        if (recordStartLoc == -1) {
            recordStartLoc = range.location; // 第一次位置需要特殊记录；也就是说每次while循环只执行一次
        } else {
            recordStartLoc += childString.length + range.location;
        }
        [locationMuArray addObject:[NSNumber numberWithUnsignedInteger:recordStartLoc]];//存储起始位置
        substring = [substring substringFromIndex:range.location + range.length];//把找到的字串截取掉
        range = [substring rangeOfString:childString];
    }
    return locationMuArray.copy;
}

@end
