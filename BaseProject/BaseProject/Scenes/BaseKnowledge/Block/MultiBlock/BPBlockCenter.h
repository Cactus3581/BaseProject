//
//  BPBlockCenter.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/28.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 实现block的一对多关系

@interface BPBlockCenter : NSObject

+ (BPBlockCenter *)shareCenter;

// 方案1 ，但是不能解决循环引用的问题
- (void)addObserver:(id)observer callback:(dispatch_block_t)callback;

- (void)removeObserver:(id)observer;

// 方案2 ，能解决循环引用的问题
- (void)addObserver1:(id)observer callback:(dispatch_block_t)callback;

// 方案3 ，对监听优化
- (void)addObserver2:(id)observer callback:(dispatch_block_t)callback;

@end

NS_ASSUME_NONNULL_END
