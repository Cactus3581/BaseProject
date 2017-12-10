//
//  NSSet+Block.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSSet (JKBlock)
- (void)jk_each:(void (^)(id))block;
- (void)jk_eachWithIndex:(void (^)(id, int))block;
- (NSArray *)jk_map:(id (^)(id object))block;
- (NSArray *)jk_select:(BOOL (^)(id object))block;
- (NSArray *)jk_reject:(BOOL (^)(id object))block;
- (NSArray *)jk_sort;
- (id)jk_reduce:(id(^)(id accumulator, id object))block;
- (id)jk_reduce:(id)initial withBlock:(id(^)(id accumulator, id object))block;
@end
