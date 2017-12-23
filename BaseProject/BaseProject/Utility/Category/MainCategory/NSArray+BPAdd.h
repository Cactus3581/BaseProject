//
//  NSArray+BPAdd.h
//  CatergoryDemo
//
//  Created by xiaruzhen on 16/5/13.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (BPAdd)

+ (nullable NSArray *)bp_arrayFromPlist:(NSString *)plistName;

- (nullable id)bp_randomObject;

- (nullable NSArray *)bp_arrayAfterRandom;

/**objectAtIndex的防止越界的版本，越界返回nil*/
- (nullable id)bp_objectOrNilAtIndex:(NSUInteger)index;


- (nullable NSString *)bp_jsonStringEncoded;
- (nullable NSString *)bp_jsonPrettyStringEncoded;


@end

NS_ASSUME_NONNULL_END
