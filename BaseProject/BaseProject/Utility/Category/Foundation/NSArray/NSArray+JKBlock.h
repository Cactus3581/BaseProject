//
//  NSArray+Block.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JKBlock)
- (void)jk_each:(void (^)(id object))block;
- (void)jk_eachWithIndex:(void (^)(id object, NSUInteger index))block;
- (NSArray *)jk_map:(id (^)(id object))block;
- (NSArray *)jk_filter:(BOOL (^)(id object))block;
- (NSArray *)jk_reject:(BOOL (^)(id object))block;
- (id)jk_detect:(BOOL (^)(id object))block;
- (id)jk_reduce:(id (^)(id accumulator, id object))block;
- (id)jk_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;
@end
