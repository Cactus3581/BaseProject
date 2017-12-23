//
//  NSDecimalNumber+Extensions.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>
// Rounding policies :
// Original
//    value 1.2  1.21  1.25  1.35  1.27

// Plain    1.2  1.2   1.3   1.4   1.3
// Down     1.2  1.2   1.2   1.3   1.2
// Up       1.2  1.3   1.3   1.4   1.3
// Bankers  1.2  1.2   1.2   1.4   1.3
@interface NSDecimalNumber (BPExtensions)
/**
 *  @brief  四舍五入 NSRoundPlain
 *
 *  @param scale 限制位数
 *
 *  @return 返回结果
 */
- (NSDecimalNumber*)_roundToScale:(NSUInteger)scale;
/**
 *  @brief  四舍五入
 *
 *  @param scale        限制位数
 *  @param roundingMode NSRoundingMode
 *
 *  @return 返回结果
 */
- (NSDecimalNumber*)_roundToScale:(NSUInteger)scale mode:(NSRoundingMode)roundingMode;

- (NSDecimalNumber*)_decimalNumberWithPercentage:(float)percent;
- (NSDecimalNumber*)_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage;
- (NSDecimalNumber*)_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage roundToScale:(NSUInteger)scale;
- (NSDecimalNumber*)_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue;
- (NSDecimalNumber*)_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue roundToScale:(NSUInteger)scale;

@end
