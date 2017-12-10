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
- (void)_each:(void (^)(id k, id v))block;
- (void)_eachKey:(void (^)(id k))block;
- (void)_eachValue:(void (^)(id v))block;
- (NSArray *)_map:(id (^)(id key, id value))block;
- (NSDictionary *)_pick:(NSArray *)keys;
- (NSDictionary *)_omit:(NSArray *)key;

@end
