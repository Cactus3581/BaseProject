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
+ (id)_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)_cancelBlock:(id)block;
+ (void)_cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

@end
