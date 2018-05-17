//
//  DHCache.h
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/15.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHCacheProtocol.h"

@interface DHCache : NSObject<DHCacheProtocol>

- (id)initWithCount:(NSInteger)count;
- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

- (void)removeFirstObjectInCache;

- (NSInteger)totalVCCount;

@end
