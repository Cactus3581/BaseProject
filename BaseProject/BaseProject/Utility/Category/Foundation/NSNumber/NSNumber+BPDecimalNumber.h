//
//  NSNumber+BPDecimalNumber.h
//  BaseProject
//
//  Created by Ryan on 2017/11/8.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (BPDecimalNumber)
- (NSNumber *)doubleDecimalNumberWithFloat:(CGFloat)number;

- (NSNumber *)decimalNumberWithString:(NSString *)number;

- (NSString *)stringDecimalNumber;
@end
