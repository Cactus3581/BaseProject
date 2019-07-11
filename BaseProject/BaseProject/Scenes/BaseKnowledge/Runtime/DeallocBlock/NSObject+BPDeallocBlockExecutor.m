//
//  NSObject+BPDeallocBlockExecutor.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/27.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "NSObject+BPDeallocBlockExecutor.h"
#import <objc/runtime.h>

static dispatch_queue_t _deallocCallbackQueue = 0;

const void *BPDeallocExecutorsKey = &BPDeallocExecutorsKey;

@implementation NSObject (BPDeallocBlockExecutor)

- (void)bp_executeAtDealloc:(BPDeallocExecutorBlock)block {
    if (block) {
        BPDeallocExecutor *executor = [[BPDeallocExecutor alloc] initWithBlock:block];
        dispatch_sync(self.deallocCallbackQueue, ^{
            [[self bp_deallocExecutors] addObject:executor];
        });
    }
}

// 懒加载获取串行队列，保证线程安全
- (dispatch_queue_t)deallocCallbackQueue {
    if (_deallocCallbackQueue == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _deallocCallbackQueue = dispatch_queue_create("com.cactus.BPDeallocBlockExecutor.deallocCallbackQueue", DISPATCH_QUEUE_SERIAL);
        });
    }
    return _deallocCallbackQueue;
}

// 懒加载获取NSHashTable，作为任务事件的容器
- (NSHashTable *)bp_deallocExecutors {
    NSHashTable *table = objc_getAssociatedObject(self,BPDeallocExecutorsKey);
    if (!table) {
        table = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
        objc_setAssociatedObject(self, BPDeallocExecutorsKey, table, OBJC_ASSOCIATION_RETAIN);
    }
    return table;
}

@end
