//
//  NSDictionary+BPSafeAccess.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (BPSafeAccess)
- (BOOL)_hasKey:(NSString *)key;

- (NSString *)_stringForKey:(id)key;

- (NSNumber *)_numberForKey:(id)key;

- (NSDecimalNumber *)_decimalNumberForKey:(id)key;

- (NSArray *)_arrayForKey:(id)key;

- (NSDictionary *)_dictionaryForKey:(id)key;

- (NSInteger)_integerForKey:(id)key;

- (NSUInteger)_unsignedIntegerForKey:(id)key;

- (BOOL)_boolForKey:(id)key;

- (int16_t)_int16ForKey:(id)key;

- (int32_t)_int32ForKey:(id)key;

- (int64_t)_int64ForKey:(id)key;

- (char)_charForKey:(id)key;

- (short)_shortForKey:(id)key;

- (float)_floatForKey:(id)key;

- (double)_doubleForKey:(id)key;

- (long long)_longLongForKey:(id)key;

- (unsigned long long)_unsignedLongLongForKey:(id)key;

- (NSDate *)_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)_CGFloatForKey:(id)key;

- (CGPoint)_pointForKey:(id)key;

- (CGSize)_sizeForKey:(id)key;

- (CGRect)_rectForKey:(id)key;
@end

#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(SafeAccess)

- (void)_setObj:(id)i forKey:(NSString *)key;

- (void)_setString:(NSString *)i forKey:(NSString *)key;

- (void)_setBool:(BOOL)i forKey:(NSString *)key;

- (void)_setInt:(int)i forKey:(NSString *)key;

- (void)_setInteger:(NSInteger)i forKey:(NSString *)key;

- (void)_setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key;

- (void)_setCGFloat:(CGFloat)f forKey:(NSString *)key;

- (void)_setChar:(char)c forKey:(NSString *)key;

- (void)_setFloat:(float)i forKey:(NSString *)key;

- (void)_setDouble:(double)i forKey:(NSString *)key;

- (void)_setLongLong:(long long)i forKey:(NSString *)key;

- (void)_setPoint:(CGPoint)o forKey:(NSString *)key;

- (void)_setSize:(CGSize)o forKey:(NSString *)key;

- (void)_setRect:(CGRect)o forKey:(NSString *)key;
@end
