//
//  NSDictionary+BPAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (BPAdd)

- (nullable NSDictionary *)bp_dictionaryFromPlist:(NSString *)plistName;

- (BOOL)bp_containsObjectForKey:(id)key;
- (nullable NSString *)bp_jsonStringEncoded;
- (nullable NSString *)bp_jsonPrettyStringEncoded;
/**根据keys数组返回对应的字典*/
- (nullable NSDictionary *)bp_entriesForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END
