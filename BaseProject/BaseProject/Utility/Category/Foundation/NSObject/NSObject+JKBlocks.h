//
//  NSObject+JKBlocks.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSObject (JKBlocks)
+ (id)jk_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)jk_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)jk_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)jk_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)jk_cancelBlock:(id)block;
+ (void)jk_cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

@end
