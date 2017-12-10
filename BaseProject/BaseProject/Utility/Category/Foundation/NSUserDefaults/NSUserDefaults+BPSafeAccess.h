//
//  NSUserDefaults+SafeAccess.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (BPSafeAccess)
+ (NSString *)_stringForKey:(NSString *)defaultName;

+ (NSArray *)_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)_dictionaryForKey:(NSString *)defaultName;

+ (NSData *)_dataForKey:(NSString *)defaultName;

+ (NSArray *)_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)_integerForKey:(NSString *)defaultName;

+ (float)_floatForKey:(NSString *)defaultName;

+ (double)_doubleForKey:(NSString *)defaultName;

+ (BOOL)_boolForKey:(NSString *)defaultName;

+ (NSURL *)_URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)_setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)_arcObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)_setArcObject:(id)value forKey:(NSString *)defaultName;
@end
