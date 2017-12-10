//
//  NSSet+Block.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSSet (BPBlock)
- (void)_each:(void (^)(id))block;
- (void)_eachWithIndex:(void (^)(id, int))block;
- (NSArray *)_map:(id (^)(id object))block;
- (NSArray *)_select:(BOOL (^)(id object))block;
- (NSArray *)_reject:(BOOL (^)(id object))block;
- (NSArray *)_sort;
- (id)_reduce:(id(^)(id accumulator, id object))block;
- (id)_reduce:(id)initial withBlock:(id(^)(id accumulator, id object))block;
@end
