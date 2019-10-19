//
//  BPCacheTool.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,BPCacheToolType) {
   BPCacheToolTypeMemoryAndDisk,
   BPCacheToolTypeMemory,
   BPCacheToolTypeDisk
};

@interface BPCacheTool : NSObject

@property (copy, readonly) NSString *name;
@property (copy, readonly) NSString *path;

#pragma mark - initialze

+ (instancetype)bp_cacheToolWithType:(BPCacheToolType)type name:(NSString *)name;

+ (instancetype)bp_cacheToolWithType:(BPCacheToolType)type path:(NSString *)path;

+ (instancetype)bp_cacheToolWithType:(BPCacheToolType)type path:(NSString *)path inlineThreshold:(NSUInteger)inlineThreshold;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

#pragma mark - add

- (void)bp_setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;


- (void)bp_setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block;

#pragma mark - delete

- (void)bp_removeObjectForKey:(NSString *)key;


- (void)bp_removeObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key))block;


- (void)bp_removeAllObjects;


- (void)bp_removeAllObjectsWithBlock:(void(^)(void))block;


- (void)bp_removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress
                                    endBlock:(nullable void(^)(BOOL error))end;

#pragma mark - check

- (BOOL)bp_containsObjectForKey:(NSString *)key;


- (void)bp_containsObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, BOOL contains))block;


- (nullable id<NSCoding>)bp_objectForKey:(NSString *)key;

- (nullable NSArray *)bp_allObjects;

- (void)bp_allObjectsWithBlock:(void(^)(NSArray * __nullable objects))block;


- (void)bp_objectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, __nullable id<NSCoding> object))block;

#pragma mark - for memoryCache

@property (readonly) NSUInteger memoryTotalCount;

@property (readonly) NSUInteger memoryTotalCost;

@property NSUInteger memoryCountLimit;

@property NSUInteger memoryCostLimit;

@property NSTimeInterval memoryAgeLimit;

@property NSTimeInterval memoryAutoTrimInterval;

@property BOOL shouldRemoveAllObjectsOnMemoryWarning;

@property BOOL shouldRemoveAllObjectsWhenEnteringBackground;

- (void)bp_setMemoryWarningConfig:(void(^)(BPCacheTool *cacheTool))memoryWarningConfig enteringBackgroundConfig:(void(^)(BPCacheTool *cacheTool))enteringBackgroundConfig;

@property BOOL releaseOnMainThread;

@property BOOL releaseAsynchronously;

- (void)bp_memoryTrimToCount:(NSUInteger)count;


- (void)bp_memoryTrimToCost:(NSUInteger)cost;


- (void)bp_memoryTrimToAge:(NSTimeInterval)age;

#pragma mark - for diskCache

@property (readonly) NSUInteger inlineThreshold;

@property NSUInteger diskCountLimit;

@property NSUInteger diskCostLimit;

@property NSTimeInterval diskAgeLimit;

@property NSUInteger freeDiskSpaceLimit;

@property NSTimeInterval diskAutoTrimInterval;

@property BOOL errorLogsEnabled;

- (void)bp_setCustomFileNameConfig:(NSString *(^)(NSString *key))config;

- (NSInteger)bp_diskTotalCount;

- (void)bp_diskTotalCountWithBlock:(void(^)(NSInteger totalCount))block;

- (NSInteger)bp_diskTotalCost;

- (void)bp_diskTotalCostWithBlock:(void(^)(NSInteger totalCost))block;

- (void)bp_diskTrimToCount:(NSUInteger)count;

- (void)bp_diskTrimToCount:(NSUInteger)count withBlock:(void(^)(void))block;

- (void)bp_diskTrimToCost:(NSUInteger)cost;

- (void)bp_diskTrimToCost:(NSUInteger)cost withBlock:(void(^)(void))block;

- (void)bp_diskTrimToAge:(NSTimeInterval)age;

- (void)bp_diskTrimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block;

+ (nullable NSData *)bp_getExtendedDataFromObject:(id)object;

+ (void)bp_setExtendedData:(nullable NSData *)extendedData toObject:(id)object;

@end

NS_ASSUME_NONNULL_END
