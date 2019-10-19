//
//  BPAnotherNotificationCenter.m
//  BaseProject
//
//  Created by Ryan on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPAnotherNotificationCenter.h"
#import "BPEventBlkPool.h"
#import "NSObject+BPAnotherObserver.h"

static NSString * const kDefaultNotificationName = @"BPAnotherDefaultNotification";

#define bp_dispatch_queue_main_async_safe(block)\
if ([[NSThread currentThread] isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

@interface BPAnotherNotificationCenter ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMapTable<NSString *, BPEventBlkPool *> *> *dict;

@end


@implementation BPAnotherNotificationCenter

+ (instancetype)defaultCenter {
    static BPAnotherNotificationCenter *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    });
    return sharedInstance;
}

#pragma mark - 注册观察者
- (void)addObserverForName:(NSString *)name observer:(NSObject *)observer usingBlock:(BPEventCallBlk)block {
    
    if (!block) {
        return;
    }
    if (!observer) {
        return;
    }
    if (!name.length) {
        name = kDefaultNotificationName;
    }
    
    bp_dispatch_queue_main_async_safe((^{
        NSMapTable *observerBlockMap = self.dict[name];// 通过通知名字获取map，map里存储着观察者和block事件
        if (!observerBlockMap) {
            observerBlockMap = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
            [self.dict setValue:observerBlockMap forKey:name];
        }
        
         NSString *observerKey = [NSString stringWithFormat:@"%p", observer.eventBlkPool]; // 懒加载获取观察者的block事件池，然后取地址作为观察者的key
         BPEventBlkPool *eventBlkPool = [observerBlockMap objectForKey:observerKey];
         if (!eventBlkPool) {
             eventBlkPool = observer.eventBlkPool;//创建了block事件池对象
             [observerBlockMap setObject:eventBlkPool forKey:observerKey];
         }
         BPEventBlk *blk = [[BPEventBlk alloc] init];
         blk.callBlk = block;
         
         [eventBlkPool.pool addObject:blk];
         
    }));
}

#pragma mark - 发送通知
- (void)postNotificationName:(NSString *)name info:(id)info {
    bp_dispatch_queue_main_async_safe(^{
        NSMapTable *observerBlockMap = [self.dict valueForKey:name];
        if (!observerBlockMap) {
            return;
        }
        for (NSString *observerKey in observerBlockMap) {
            BPEventBlkPool *eventBlkPool = [observerBlockMap objectForKey:observerKey];
            for (BPEventBlk *blk in eventBlkPool.pool) {
                blk.callBlk(info);
            }
        }
    });
}

// 移出指定observer下的所有通知
- (void)removeObserver:(NSObject *)observer {
    bp_dispatch_queue_main_async_safe((^{
        for (NSString *notiName in self.dict) {
            NSMapTable *observerBlockMap = [self.dict valueForKey:notiName];
            if (!observerBlockMap) {
                continue;
            }
            NSString *observerKey = [NSString stringWithFormat:@"%p", observer.eventBlkPool];
            BPEventBlkPool *eventBlkPool = [observerBlockMap objectForKey:observerKey];
            if (!eventBlkPool) {
                continue;
            }
            [eventBlkPool.pool removeAllObjects];
            [observerBlockMap removeObjectForKey:observerKey];
        }
    }));
}


// 移出指定observer下的指定通知
- (void)removeObserver:(NSObject *)observer name:(NSString *)name {
    if (!name) {
        name = kDefaultNotificationName;
    }
    if (!observer) {
        return;
    }
    NSMapTable *observerBlockMap = self.dict[name];
    if (!observerBlockMap) {
        return;
    }
    bp_dispatch_queue_main_async_safe((^{
        NSString *obserKey = [NSString stringWithFormat:@"%p", observer.eventBlkPool];
        BPEventBlkPool *eventBlkPool = [observerBlockMap objectForKey:obserKey];
        [eventBlkPool.pool removeAllObjects];
        [observerBlockMap removeObjectForKey:obserKey];
    }));
}

#pragma mark - getter
- (NSMutableDictionary<NSString *,NSMapTable<NSString *,BPEventBlkPool *> *> *)dict {
    if (!_dict) {
        _dict = @{}.mutableCopy;
    }
    return _dict;
}

@end

