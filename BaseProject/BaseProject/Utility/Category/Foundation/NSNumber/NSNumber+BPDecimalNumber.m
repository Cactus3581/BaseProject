//
//  NSNumber+BPDecimalNumber.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/8.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSNumber+BPDecimalNumber.h"

@implementation NSNumber (BPDecimalNumber)

- (NSNumber *)doubleDecimalNumberWithFloat:(CGFloat)number {
    NSNumber * NSNumber_number = [self decimalNumberWithNumberString:[NSString stringWithFormat:@"%g",number]];
    return NSNumber_number;
}

- (NSNumber *)decimalNumberWithString:(NSString *)number {
    NSNumber * number_number = [self decimalNumberWithNumberString:[NSString stringWithFormat:@"%g",[number doubleValue]]];
    return number_number;
}

- (NSString *)stringDecimalNumber {
    CGFloat numberValue = [self doubleValue];
    NSString *numberStr = [NSString stringWithFormat:@"%g",numberValue];
    return numberStr;
}

- (NSDecimalNumber *)decimalNumberWithNumberString:(NSString *)numberValue {
    return [NSDecimalNumber decimalNumberWithString:numberValue];
}

@end
