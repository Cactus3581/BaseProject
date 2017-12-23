//
//  NSMutableArray+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 16/5/13.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (BPAdd)

- (void)bp_removeFirstObject;
- (void)bp_removeLastObject;

/**移除并返回第一个元素*/
- (nullable id)bp_popFirstObject;
/**移除并返回最后一个元素*/
- (nullable id)bp_popLastObject;
/**移除并返回指定元素*/
- (nullable id)bp_popObjectAtIndexPath:(NSUInteger)index;
/**插入数组*/
- (void)bp_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;
/**反转数组*/
- (void)bp_reverse;
/**随机整理数组*/
- (void)bp_random;

@end

NS_ASSUME_NONNULL_END
