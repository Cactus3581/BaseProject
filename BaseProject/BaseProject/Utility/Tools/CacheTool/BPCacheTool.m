//
//  BPCacheTool.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCacheTool.h"
#import <YYDiskCache.h>
#import <YYMemoryCache.h>
#import <objc/runtime.h>

static NSString *BPCacheToolExtendedDataKey = @"BPCacheToolExtendedDataKey";

@implementation BPCacheTool{
    YYDiskCache *_diskCache;
    YYMemoryCache *_memoryCache;
}

+ (instancetype)bp_cacheToolWithType:(BPCacheToolType)type name:(NSString *)name {
    if (!name.length) return nil;
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [cacheFolder stringByAppendingPathComponent:name];
    return [[self alloc] _initWithType:type path:path inlineThreshold:1024 * 20];
}

+ (instancetype)bp_cacheToolWithType:(BPCacheToolType)type path:(NSString *)path {
    return [[self alloc] _initWithType:type path:path inlineThreshold:1024 * 20];
}

+ (instancetype)bp_cacheToolWithType:(BPCacheToolType)type path:(NSString *)path inlineThreshold:(NSUInteger)inlineThreshold{
    return [[self alloc] _initWithType:type path:path inlineThreshold:inlineThreshold];
}

- (instancetype)_initWithType:(BPCacheToolType)type path:(NSString *)path inlineThreshold:(NSUInteger)inlineThreshold{
    if (!path.length) return nil;
    self = [super init];
    if (!self) return nil;
    if (type ==BPCacheToolTypeDisk || type ==BPCacheToolTypeMemoryAndDisk) {
        YYDiskCache *diskCache = [[YYDiskCache alloc] initWithPath:path inlineThreshold:inlineThreshold];
        _diskCache = diskCache;
        _inlineThreshold = inlineThreshold;
    }
    NSString *name = [path lastPathComponent];
    if (type ==BPCacheToolTypeMemory || type ==BPCacheToolTypeMemoryAndDisk) {
        YYMemoryCache *memoryCache = [YYMemoryCache new];
        memoryCache.name = name;
        _memoryCache = memoryCache;
    }
    if (!_diskCache && !_memoryCache) {
        return nil;
    }
    _name = name;
    _path = _diskCache ? path : nil;
    return self;
}

- (BOOL)bp_containsObjectForKey:(NSString *)key {
    return [_memoryCache containsObjectForKey:key] || [_diskCache containsObjectForKey:key];
}

- (void)bp_containsObjectForKey:(NSString *)key withBlock:(void (^)(NSString *key, BOOL contains))block {
    if (!block) return;
    if ([_memoryCache containsObjectForKey:key]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            block(key, YES);
        });
    } else  {
        if (_diskCache) {
            [_diskCache containsObjectForKey:key withBlock:block];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                block(key, NO);
            });
        }
    }
}

- (id<NSCoding>)bp_objectForKey:(NSString *)key {
    id<NSCoding> object = [_memoryCache objectForKey:key];
    if (!object) {
        object = [_diskCache objectForKey:key];
        if (object) {
            [_memoryCache setObject:object forKey:key];
        }
    }
    return object;
}

- (void)bp_objectForKey:(NSString *)key withBlock:(void (^)(NSString *key, id<NSCoding> object))block {
    if (!block) return;
    id<NSCoding> object = [_memoryCache objectForKey:key];
    if (object) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            block(key, object);
        });
    } else {
        if (_diskCache) {
            [_diskCache objectForKey:key withBlock:block];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                block(key, nil);
            });
        }
    }
}

#warning 待补充
//- (NSArray *)bp_allObjects {
//    return [_diskCache allObjects];
//}
//
//- (void)bp_allObjectsWithBlock:(void(^)(NSArray *objects))block{
//    if (!block || !_diskCache) return;
//    [_diskCache allObjectsWithBlock:block];
//}

- (void)bp_setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [_memoryCache setObject:object forKey:key];
    [_diskCache setObject:object forKey:key];
}

- (void)bp_setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block {
    [_memoryCache setObject:object forKey:key];
    [_diskCache setObject:object forKey:key withBlock:block];
}

- (void)bp_removeObjectForKey:(NSString *)key {
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key];
}

- (void)bp_removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *key))block {
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key withBlock:block];
}

- (void)bp_removeAllObjects {
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjects];
}

- (void)bp_removeAllObjectsWithBlock:(void(^)(void))block {
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjectsWithBlock:block];
}

- (void)bp_removeAllObjectsWithProgressBlock:(void(^)(int removedCount, int totalCount))progress
                                    endBlock:(void(^)(BOOL error))end {
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

- (NSString *)description {
    if (_name) return [NSString stringWithFormat:@"<%@: %p> (%@)", self.class, self, _name];
    else return [NSString stringWithFormat:@"<%@: %p>", self.class, self];
}

#pragma mark - for memoryCache

- (NSUInteger)memoryTotalCount{
    return _memoryCache.totalCost;
}

- (NSUInteger)memoryTotalCost{
    return _memoryCache.totalCount;
}

- (NSUInteger)memoryCountLimit{
    return _memoryCache.countLimit;
}

- (NSUInteger)memoryCostLimit{
    return _memoryCache.costLimit;
}

- (NSTimeInterval)memoryAgeLimit{
    return _memoryCache.ageLimit;
}

- (NSTimeInterval)memoryAutoTrimInterval{
    return _memoryCache.autoTrimInterval;
}

- (BOOL)releaseOnMainThread{
    return _memoryCache.releaseOnMainThread;
}

- (BOOL)releaseAsynchronously{
    return _memoryCache.releaseAsynchronously;
}

- (BOOL)shouldRemoveAllObjectsOnMemoryWarning{
    return _memoryCache.shouldRemoveAllObjectsOnMemoryWarning;
}

- (BOOL)shouldRemoveAllObjectsWhenEnteringBackground{
    return _memoryCache.shouldRemoveAllObjectsWhenEnteringBackground;
}

- (void)setMemoryCountLimit:(NSUInteger)memoryCountLimit{
    _memoryCache.countLimit = memoryCountLimit;
}

- (void)setMemoryCostLimit:(NSUInteger)memoryCostLimit{
    _memoryCache.costLimit = memoryCostLimit;
}

- (void)setMemoryAgeLimit:(NSTimeInterval)memoryAgeLimit{
    _memoryCache.ageLimit = memoryAgeLimit;
}

- (void)setMemoryAutoTrimInterval:(NSTimeInterval)memoryAutoTrimInterval{
    _memoryCache.autoTrimInterval = memoryAutoTrimInterval;
}

- (void)setShouldRemoveAllObjectsOnMemoryWarning:(BOOL)shouldRemoveAllObjectsOnMemoryWarning{
    _memoryCache.shouldRemoveAllObjectsOnMemoryWarning = shouldRemoveAllObjectsOnMemoryWarning;
}

- (void)setShouldRemoveAllObjectsWhenEnteringBackground:(BOOL)shouldRemoveAllObjectsWhenEnteringBackground{
    _memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = shouldRemoveAllObjectsWhenEnteringBackground;
}

- (void)setReleaseAsynchronously:(BOOL)releaseAsynchronously{
    _memoryCache.releaseAsynchronously = releaseAsynchronously;
}

- (void)setReleaseOnMainThread:(BOOL)releaseOnMainThread{
    _memoryCache.releaseOnMainThread = releaseOnMainThread;
}

- (void)bp_setMemoryWarningConfig:(void (^)(BPCacheTool * _Nonnull))memoryWarningConfig enteringBackgroundConfig:(void (^)(BPCacheTool * _Nonnull))enteringBackgroundConfig{
    weakify(self);
    _memoryCache.didReceiveMemoryWarningBlock = ^(YYMemoryCache *cache){
        strongify(self);
        memoryWarningConfig(self);
    };
    _memoryCache.didEnterBackgroundBlock = ^(YYMemoryCache *cache){
        strongify(self);
        enteringBackgroundConfig(self);
    };
}

- (void)bp_memoryTrimToCount:(NSUInteger)count {
    [_memoryCache trimToCount:count];
    
}

- (void)bp_memoryTrimToCost:(NSUInteger)cost {
    [_memoryCache trimToCost:cost];
}

- (void)bp_memoryTrimToAge:(NSTimeInterval)age {
    [_memoryCache trimToAge:age];
}

#pragma mark - for diskCache

- (NSUInteger)diskCostLimit{
    return _diskCache.costLimit;
}

- (NSUInteger)diskCountLimit{
    return _diskCache.countLimit;
}

- (NSTimeInterval)diskAgeLimit{
    return _diskCache.ageLimit;
}

- (NSTimeInterval)diskAutoTrimInterval{
    return _diskCache.autoTrimInterval;
}

- (NSUInteger)freeDiskSpaceLimit{
    return _diskCache.freeDiskSpaceLimit;
}

- (BOOL)errorLogsEnabled{
    return _diskCache.errorLogsEnabled;
}

- (void)setDiskCostLimit:(NSUInteger)diskCostLimit{
    _diskCache.costLimit = diskCostLimit;
}

- (void)setDiskCountLimit:(NSUInteger)diskCountLimit{
    _diskCache.countLimit = diskCountLimit;
}

- (void)setDiskAgeLimit:(NSTimeInterval)diskAgeLimit{
    _diskCache.ageLimit = diskAgeLimit;
}

- (void)setFreeDiskSpaceLimit:(NSUInteger)freeDiskSpaceLimit{
    _diskCache.freeDiskSpaceLimit = freeDiskSpaceLimit;
}

- (void)setDiskAutoTrimInterval:(NSTimeInterval)diskAutoTrimInterval{
    _diskCache.autoTrimInterval = diskAutoTrimInterval;
}

- (void)setErrorLogsEnabled:(BOOL)errorLogsEnabled{
    _diskCache.errorLogsEnabled = errorLogsEnabled;
}

- (void)bp_setCustomFileNameConfig:(NSString *(^)(NSString *key))config {
    _diskCache.customFileNameBlock = config;
}

- (NSInteger)bp_diskTotalCount {
    return [_diskCache totalCount];
}

- (void)bp_diskTotalCountWithBlock:(void(^)(NSInteger totalCount))block {
    [_diskCache totalCountWithBlock:block];
}

- (NSInteger)bp_diskTotalCost {
    return [_diskCache totalCost];
}

- (void)bp_diskTotalCostWithBlock:(void(^)(NSInteger totalCost))block {
    [_diskCache totalCostWithBlock:block];
}

- (void)bp_diskTrimToCount:(NSUInteger)count {
    [_diskCache trimToCount:count];
}

- (void)bp_diskTrimToCount:(NSUInteger)count withBlock:(void(^)(void))block {
    [_diskCache trimToCount:count withBlock:block];
}

- (void)bp_diskTrimToCost:(NSUInteger)cost {
    [_diskCache trimToCost:cost];
}

- (void)bp_diskTrimToCost:(NSUInteger)cost withBlock:(void(^)(void))block {
    [_diskCache trimToCost:cost withBlock:block];
}

- (void)bp_diskTrimToAge:(NSTimeInterval)age {
    [_diskCache trimToAge:age];
}

- (void)bp_diskTrimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block {
    [_diskCache trimToAge:age withBlock:block];
}

+ (NSData *)bp_getExtendedDataFromObject:(id)object{
    if (!object) return nil;
    return (NSData *)objc_getAssociatedObject(object, &BPCacheToolExtendedDataKey);
}

+ (void)bp_setExtendedData:(nullable NSData *)extendedData toObject:(id)object {
    if (!object) return;
    objc_setAssociatedObject(object, &BPCacheToolExtendedDataKey, extendedData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
