//
//  BPNotificationCenter.m
//  BaseProject
//
//  Created by Ryan on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPNotificationCenter.h"
#import "NSObject+BPObserver.h"

static NSString * const kDefaultNotificationName = @"BPDefaultNotification";

#define bp_dispatch_queue_main_async_safe(block)\
if ([[NSThread currentThread] isMainThread]) {\
    block();\
} else {\
    dispatch_sync(dispatch_get_main_queue(), block);\
}

@interface BPNotificationCenter ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMapTable<NSString *, NSMutableArray *> *> *dict;

@end


@implementation BPNotificationCenter

+ (instancetype)defaultCenter {
    static BPNotificationCenter *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    });
    return sharedInstance;
}

- (void)addObserverForName1:(NSString *)name observer:(NSObject *)observer usingBlock:(BPEventCallBlk)block {
    
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
        /*
         维护的数据结构
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
        
        NSString *observerAddressKey = [NSString stringWithFormat:@"%p", observer]; // 懒加载获取观察者的block事件池，然后取地址作为观察者的key
        NSMutableArray *muArray = [observerBlockMap objectForKey:observerAddressKey];
        if (!muArray) {
            //muArray = @[].mutableCopy;//创建了block事件池对象，但是出栈后会被立即释放
            muArray = observer.muArray;//创建了block事件池对象，利用观察者的强引用不让存放block的数据释放
            [observerBlockMap setObject:muArray forKey:observerAddressKey];
        }
        [muArray addObject:[block copy]];
    }));
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
        /*
         维护的数据结构
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
        
        NSString *observerAddressKey = [NSString stringWithFormat:@"%p", observer]; // 懒加载获取观察者的block事件池，然后取地址作为观察者的key
        NSMutableArray *muArray = [observerBlockMap objectForKey:observerAddressKey];
        if (!muArray) {
            //muArray = @[].mutableCopy;//创建了block事件池对象，但是出栈后会被立即释放
            muArray = observer.muArray;//创建了block事件池对象，利用观察者的强引用不让存放block的数据释放
            [observerBlockMap setObject:muArray forKey:observerAddressKey];
        }
        [muArray addObject:[block copy]];
    }));
}

#pragma mark - 发送通知
- (void)postNotificationName:(NSString *)name info:(id)info {
    bp_dispatch_queue_main_async_safe(^{
        NSMapTable *observerBlockMap = [self.dict valueForKey:name];
        if (!observerBlockMap) {
            return;
        }

        for (NSString *observerAddressKey in observerBlockMap) {
            NSMutableArray *muArray = [observerBlockMap objectForKey:observerAddressKey];
            for (BPEventCallBlk blk in muArray) {
                blk(info);
            }
        }
    });
}

// 移出指定observer下的所有通知
- (void)removeObserver:(NSObject *)observer {
    bp_dispatch_queue_main_async_safe((^{
        for (NSString *name in self.dict) {
            
            NSMapTable *observerBlockMap = self.dict[name];
            
            if (!observerBlockMap) {
                continue;
            }
            
            NSString *observerAddressKey = [NSString stringWithFormat:@"%p", observer]; // 懒加载获取观察者的block事件池，然后取地址作为观察者的key
            NSMutableArray *muArray = [observerBlockMap objectForKey:observerAddressKey];
            
            if (!muArray) {
                continue;
            }
            
            [muArray removeAllObjects];
            [observerBlockMap removeObjectForKey:observerAddressKey];
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
        NSString *observerAddressKey = [NSString stringWithFormat:@"%p", observer]; // 懒加载获取观察者的block事件池，然后取地址作为观察者的key
        NSMutableArray *muArray = [observerBlockMap objectForKey:observerAddressKey];
        [muArray removeAllObjects];
        [observerBlockMap removeObjectForKey:observerAddressKey];
    }));
}

#pragma mark - getter
- (NSMutableDictionary<NSString *,NSMapTable<NSString *,NSMutableArray *> *> *)dict {
    if (!_dict) {
        _dict = @{}.mutableCopy;
    }
    return _dict;
}

@end
