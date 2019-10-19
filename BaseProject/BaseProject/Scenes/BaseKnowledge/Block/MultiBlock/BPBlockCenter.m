//
//  BPBlockCenter.m
//  BaseProject
//
//  Created by Ryan on 2019/7/28.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPBlockCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "BPDeallocExecutor.h"
#import "NSObject+BPWatchDealloc.h"

static BPBlockCenter *single = nil;

@interface BPBlockCenter()

@property (nonatomic,strong) NSMapTable *mapTable;
@property (nonatomic,strong) NSMapTable *mapTable1;
@property (nonatomic,strong) NSHashTable *hashTable;

@end

/*
 
 Block的一对多（在单例的时候最有用）
 
 下面是一个对象最多只有block的情况，不是一个对象有多个block的情况。
 
 1. block必须得被持有，可以选择观察者对象持有，也可以选择单例对象持有。
 2. 如果选择观察者对象持有，可以通过关联对象的方式，key为观察者对象的地址，value为block；
 3. 当触发的时候，要触发每一个对象的block，所以需要一个集合来保存（弱引用）观察者对象以及block，这个集合对象可以选择数组类型的也可以选择字典类型；
 4. 触发时，遍历集合类对象，进行blk触发；
 总结：关联对象只是起到了强引用block的作用；而集合类起到了查找blk的作用；但是因为观察者对象对block强引用，所以外部调用的时候，必须weak，否则会循环引用
 
 那么为了避免循环引用，可以让单例强持有block，但是在观察者对象释放的时候，必须移除blk。所以需要监听观察者对象的释放时机，以移除blk。看最上面的方法如何监听dealloc
 
 1. 多的话，必须用一个集合来保存多个block，关键是这个集合被谁管理，也就是被谁强持有（不强持有block的话，block就会被释放），也就是选择一个对象（单例或者观察者对象）强持有集合，集合必须强持有block。并且在观察者对象释放的时候，必须释放相关的block；
 2. 如果被观察者对象持有，可以为观察者对象添加关联对象，这个关联对象就是集合。

 
 */

@implementation BPBlockCenter

+ (BPBlockCenter *)shareCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[BPBlockCenter alloc] init];
        
        single.mapTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory capacity:1];

        // key 保持不变，依然是 weak，不干扰 observer 的生命周期
        // 将 value 由 weak 改为 strong
        single.mapTable1 = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory capacity:1];
    });
    return single;
}

// 方案1 ，但是不能解决循环引用的问题：observer 持有block，block持有 observer。

- (void)addObserver:(id)observer callback:(dispatch_block_t)callback {
    // 单例仅负责维护映射关系： NSMapTable 中，Key 与 Value 属性都是 weak，谁也不持有。
    [_mapTable setObject:callback forKey:observer];
    
    // 外部观察者管理block引用；对象地址作为key
    objc_setAssociatedObject(observer,[[NSString stringWithFormat:@"%p",&observer] UTF8String],callback,OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self blk];
    });
}

- (void)blk {
    [[[_mapTable objectEnumerator] allObjects] enumerateObjectsUsingBlock:^(dispatch_block_t blk, NSUInteger idx, BOOL * _Nonnull stop) {
        blk();
    }];
}

- (void)removeObserver:(id)observer {
    // 是重置绑定，一个是移除映射关系；关联的对象，是不需要手动释放
    [self.mapTable removeObjectForKey:observer];
    objc_setAssociatedObject(observer,[[NSString stringWithFormat:@"%p",&observer] UTF8String],nil,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// 方案2 ，能解决循环引用的问题
- (void)addObserver1:(id)observer callback:(dispatch_block_t)callback {
    // 单例强持有block
    [self.mapTable1 setObject:callback forKey:observer];

    // 因为 watcher 由 observer 持有，所以要注意一下循环引用的问题
    __weak typeof(observer) weakObserver = observer;
    BPDeallocExecutor *wacher = [[BPDeallocExecutor alloc] initWithBlock:^{
        __strong typeof(observer) strongObserver = weakObserver;
        [self removeObserver1:strongObserver];
    }];
    
    objc_setAssociatedObject(observer,[[NSString stringWithFormat:@"%p",&observer] UTF8String],wacher,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self blk1];
    });
}

// 方案3 ，对监听优化
- (void)addObserver2:(id)observer callback:(dispatch_block_t)callback {
    // 单例强持有block
    [self.mapTable1 setObject:callback forKey:observer];
    
    __weak typeof(observer) weakObserver = observer;
    [observer bp_executeAtDealloc:^{
        __strong typeof(observer) strongObserver = weakObserver;
        [self removeObserver1:strongObserver];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self blk1];
    });
}

- (void)blk1 {
    [[[_mapTable1 objectEnumerator] allObjects] enumerateObjectsUsingBlock:^(dispatch_block_t blk, NSUInteger idx, BOOL * _Nonnull stop) {
        blk();
    }];
}

- (void)removeObserver1:(id)observer {
    [self.mapTable1 removeObjectForKey:observer];
    objc_setAssociatedObject(observer,[[NSString stringWithFormat:@"%p",&observer] UTF8String],nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
