//
//  NSArray+BPSafeAccess.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (BPSafeAccess)
- (id)_objectWithIndex:(NSUInteger)index;

- (NSString*)_stringWithIndex:(NSUInteger)index;

- (NSNumber*)_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)_integerWithIndex:(NSUInteger)index;

- (NSUInteger)_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)_boolWithIndex:(NSUInteger)index;

- (int16_t)_int16WithIndex:(NSUInteger)index;

- (int32_t)_int32WithIndex:(NSUInteger)index;

- (int64_t)_int64WithIndex:(NSUInteger)index;

- (char)_charWithIndex:(NSUInteger)index;

- (short)_shortWithIndex:(NSUInteger)index;

- (float)_floatWithIndex:(NSUInteger)index;

- (double)_doubleWithIndex:(NSUInteger)index;

- (NSDate *)_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)_pointWithIndex:(NSUInteger)index;

- (CGSize)_sizeWithIndex:(NSUInteger)index;

- (CGRect)_rectWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(BPSafeAccess)

- (void)_addObj:(id)i;

- (void)_addString:(NSString*)i;

- (void)_addBool:(BOOL)i;

- (void)_addInt:(int)i;

- (void)_addInteger:(NSInteger)i;

- (void)_addUnsignedInteger:(NSUInteger)i;

- (void)_addCGFloat:(CGFloat)f;

- (void)_addChar:(char)c;

- (void)_addFloat:(float)i;

- (void)_addPoint:(CGPoint)o;

- (void)_addSize:(CGSize)o;

- (void)_addRect:(CGRect)o;

@end
