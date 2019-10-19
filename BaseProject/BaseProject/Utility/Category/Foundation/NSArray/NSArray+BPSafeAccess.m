//
//  NSArray+BPSafeAccess.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSArray+BPSafeAccess.h"

@implementation NSArray (BPSafeAccess)
- (id)_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (NSString *)_stringWithIndex:(NSUInteger)index {
    id value = [self _objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}


- (NSNumber *)_numberWithIndex:(NSUInteger)index {
    id value = [self _objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString *)value];
    }
    return nil;
}

- (NSDecimalNumber *)_decimalNumberWithIndex:(NSUInteger)index {
    id value = [self _objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber *)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString *)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray *)_arrayWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary *)_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)_integerWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)_boolWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)_int16WithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)_int32WithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)_int64WithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)_charWithIndex:(NSUInteger)index{
    
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)_shortWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)_floatWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)_doubleWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self _objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)_CGFloatWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)_pointWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];

    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)_sizeWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];

    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)_rectWithIndex:(NSUInteger)index
{
    id value = [self _objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (BPSafeAccess)
- (void)_addObj:(id)i {
    if (i!=nil) {
        [self addObject:i];
    }
}

- (void)_addString:(NSString *)i {
    if (i!=nil) {
        [self addObject:i];
    }
}

- (void)_addBool:(BOOL)i {
    [self addObject:@(i)];
}

- (void)_addInt:(int)i {
    [self addObject:@(i)];
}

- (void)_addInteger:(NSInteger)i {
    [self addObject:@(i)];
}

- (void)_addUnsignedInteger:(NSUInteger)i {
    [self addObject:@(i)];
}

- (void)_addCGFloat:(CGFloat)f {
   [self addObject:@(f)];
}

- (void)_addChar:(char)c {
    [self addObject:@(c)];
}

- (void)_addFloat:(float)i {
    [self addObject:@(i)];
}

- (void)_addPoint:(CGPoint)o {
    [self addObject:NSStringFromCGPoint(o)];
}

- (void)_addSize:(CGSize)o {
   [self addObject:NSStringFromCGSize(o)];
}

- (void)_addRect:(CGRect)o {
    [self addObject:NSStringFromCGRect(o)];
}

@end
