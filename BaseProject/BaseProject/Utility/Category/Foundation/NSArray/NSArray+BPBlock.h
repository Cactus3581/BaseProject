//
//  NSArray+Block.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BPBlock)
- (void)_each:(void (^)(id object))block;
- (void)_eachWithIndex:(void (^)(id object, NSUInteger index))block;
- (NSArray *)_map:(id (^)(id object))block;
- (NSArray *)_filter:(BOOL (^)(id object))block;
- (NSArray *)_reject:(BOOL (^)(id object))block;
- (id)_detect:(BOOL (^)(id object))block;
- (id)_reduce:(id (^)(id accumulator, id object))block;
- (id)_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;
@end
