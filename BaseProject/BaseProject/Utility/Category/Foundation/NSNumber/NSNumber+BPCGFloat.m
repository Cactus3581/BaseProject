//
//  NSNumber+CGFloat.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSNumber+BPCGFloat.h"

@implementation NSNumber (BPCGFloat)

- (CGFloat)_CGFloatValue
{
#if (CGFLOAT_IS_DOUBLE == 1)
    CGFloat result = [self doubleValue];
#else
    CGFloat result = [self floatValue];
#endif
    return result;
}

- (id)initWithBPCGFloat:(CGFloat)value
{
#if (CGFLOAT_IS_DOUBLE == 1)
    self = [self initWithDouble:value];
#else
    self = [self initWithFloat:value];
#endif
    return self;
}

+ (NSNumber *)_numberWithCGFloat:(CGFloat)value
{
    NSNumber *result = [[self alloc] initWithBPCGFloat:value];
    return result;
}

@end
