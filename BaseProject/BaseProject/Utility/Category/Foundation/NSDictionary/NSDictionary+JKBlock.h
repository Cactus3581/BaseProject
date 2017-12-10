//
//  NSDictionary+JKBlock.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JKBlock)

#pragma mark - RX
- (void)jk_each:(void (^)(id k, id v))block;
- (void)jk_eachKey:(void (^)(id k))block;
- (void)jk_eachValue:(void (^)(id v))block;
- (NSArray *)jk_map:(id (^)(id key, id value))block;
- (NSDictionary *)jk_pick:(NSArray *)keys;
- (NSDictionary *)jk_omit:(NSArray *)key;

@end
