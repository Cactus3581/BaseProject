//
//  NSString+BPSearchString.h
//  BaseProject
//
//  Created by Ryan on 2018/12/21.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BPSearchString)

/**
 
 给指定的字符串着色
 */

+ (NSAttributedString *)handleColorString:(NSString *)mainString childString:(NSString *)childString color:(UIColor *) themeColor;

/**
 查找子字符串在父字符串中的所有位置
 
 @param array 起始位置数组
 @param childString 子字符串
 @return 返回NSRange数组
 */

+ (NSArray <NSValue *> *)handleAllRangesWithLocations:(NSArray *)array childString:(NSString *)childString;

/**
 查找子字符串在父字符串中的所有位置
 
 @param mainString 父字符串
 @param childString 子字符串
 @return 返回起始位置数组
 */

+ (NSArray *)handleStartLocationWithMainString:(NSString *)mainString childString:(NSString *)childString;

@end

NS_ASSUME_NONNULL_END
