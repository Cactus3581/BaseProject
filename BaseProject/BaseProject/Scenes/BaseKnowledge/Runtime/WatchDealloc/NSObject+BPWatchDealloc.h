//
//  NSObject+BPWatchDealloc.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/27.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPDeallocExecutor.h"

// 监听对象dealloc的类

/*
 如何监听一个对象的释放时机
 1. dealloc，可是跟调用方法分离了；
 2. 为NSObject创建一个分类，分类里使用关联对象保存一个集合对象，集合对象保存着一个外部传进来的参数为block的自定义对象，当主对象释放的时候，关联对象即集合对象也会跟着释放，接着自定义对象也会释放，在自定义对象的dealloc方法里，调用block，外部block即得到主对象的dealloc时机。
 3. 当然，也可以不使用集合对象，关联对象直接保存自定义的对象；但是重复调用方法的时候，关联对象会保存最后一次的外部调用；
 */

NS_ASSUME_NONNULL_BEGIN

typedef void (^BPDeallocSelfCallback)(__unsafe_unretained id owner, NSUInteger identifier);

@interface NSObject (BPWatchDealloc)

- (void)bp_executeAtDealloc:(BPDeallocExecutorBlock)block;

//- (void)bp_executeAtDealloc:(BPDeallocExecutorBlock)block __attribute__((deprecated("Deprecated in 1.2.0. Use `-bp_willDeallocWithSelfCallback:` instead.")));

@end

NS_ASSUME_NONNULL_END
