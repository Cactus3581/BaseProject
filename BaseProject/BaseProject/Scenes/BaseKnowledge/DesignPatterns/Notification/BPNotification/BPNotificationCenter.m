//
//  BPNotificationCenter.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPNotificationCenter.h"
#import "BPEventBlkPool.h"
#import "NSObject+BPObserver.h"

static NSString * const kDefaultNotificationName = @"PSSDefaultNotification";

#define bp_dispatch_queue_main_async_safe(block)\
if ([[NSThread currentThread] isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

@interface BPNotificationCenter ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMapTable<NSString *, BPEventBlkPool *> *> *dict;

@end


@implementation BPNotificationCenter

+ (instancetype)defaultCenter {
    static BPNotificationCenter *sharedInstance;
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
    BPLog(@"addObserverForName 前 dict = %@",self.dict);

    bp_dispatch_queue_main_async_safe((^{
        /*
         // 这个字典是NSMapTable，可以对持有的Value弱引用
         @{
            @"通知名字": @{
                @"观察者内存地址生成的字符串_1": [blk1,blk2],
                @"观察者内存地址生成的字符串_2": [blk1,blk2],
            }
         };
         */
        NSMapTable *observerBlockMap = self.dict[name];// 通过通知名字获取map，map里存储着观察者和block事件
        if (!observerBlockMap) {
            observerBlockMap = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
            [self.dict setValue:observerBlockMap forKey:name];
        }
        /*
        NSString *observerKey = [NSString stringWithFormat:@"%p", observer.eventBlkPool]; // 懒加载获取观察者的block事件池，然后取地址作为观察者的key
        BPEventBlkPool *eventBlkPool = [observerBlockMap objectForKey:observerKey];
        if (!eventBlkPool) {
            eventBlkPool = observer.eventBlkPool;//创建了block事件池对象
            [observerBlockMap setObject:eventBlkPool forKey:observerKey];
        }
        BPEventBlk *blk = [[BPEventBlk alloc] init];
        blk.callBlk = block;

        [eventBlkPool.pool addObject:blk];
         */
        
        NSString *observerKey = [NSString stringWithFormat:@"%p", observer]; // 懒加载获取观察者的block事件池，然后取地址作为观察者的key
        NSMutableArray *muArray = [observerBlockMap objectForKey:observerKey];
        if (!muArray) {
            muArray = @[].mutableCopy;//创建了block事件池对象
            [observerBlockMap setObject:muArray forKey:observerKey];
        }
        [muArray addObject:[block copy]];
        BPLog(@"addObserverForName 后 dict = %@",self.dict);
    }));
}

#pragma mark - 发送通知
- (void)postNotificationName:(NSString *)name info:(id)info {
    bp_dispatch_queue_main_async_safe(^{
        NSMapTable *observerBlockMap = [self.dict valueForKey:name];
        if (!observerBlockMap) {
            return;
        }
        /*
        for (NSString *observerKey in observerBlockMap) {
            BPEventBlkPool *eventBlkPool = [observerBlockMap objectForKey:observerKey];
            for (BPEventBlk *blk in eventBlkPool.pool) {
                blk.callBlk(info);
            }
        }
         */
        BPLog(@"blk dict = %@",observerBlockMap);

        for (NSString *observerKey in observerBlockMap) {
            NSMutableArray *muArray = [observerBlockMap objectForKey:observerKey];
            BPLog(@"return dict = %@",self.dict);

            for (BPEventCallBlk blk in muArray) {
                BPLog(@"blk dict = %@",self.dict);

                blk(info);
            }
        }
        BPLog(@"postNotificationName dict = %@",self.dict);
    });
}

// 移出指定observer下的所有通知
- (void)removeObserver:(NSObject *)observer {
    bp_dispatch_queue_main_async_safe((^{
        for (NSString *notiName in self.dict) {
            NSMapTable *notiDic = [self.dict valueForKey:notiName];
            if (!notiDic) {
                continue;
            }
            NSString *observerKey = [NSString stringWithFormat:@"%p", observer.eventBlkPool];
            BPEventBlkPool *eventBlkPool = [notiDic objectForKey:observerKey];
            if (!eventBlkPool) {
                continue;
            }
            [eventBlkPool.pool removeAllObjects];
            [notiDic removeObjectForKey:observerKey];
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
    NSMapTable *notiDic = self.dict[name];
    if (!notiDic) {
        return;
    }
    bp_dispatch_queue_main_async_safe((^{
        NSString *obserKey = [NSString stringWithFormat:@"%p", observer.eventBlkPool];
        BPEventBlkPool *eventBlkPool = [notiDic objectForKey:obserKey];
        [eventBlkPool.pool removeAllObjects];
        [notiDic removeObjectForKey:obserKey];
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
