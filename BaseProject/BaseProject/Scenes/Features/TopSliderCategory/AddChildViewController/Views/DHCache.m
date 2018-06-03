//
//  DHCache.m
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/15.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import "DHCache.h"

@interface DHCache ()
{
    NSInteger _capacity;
}
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation DHCache

- (id)initWithCount:(NSInteger)count
{
    if (self = [super init]) {
        _capacity = count;
        _dictionary = [NSMutableDictionary dictionaryWithCapacity:_capacity];
        _array = [NSMutableArray arrayWithCapacity:_capacity];
    }
    return self;
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    if (![_array containsObject:key]) {
        if (_array.count < _capacity) {
            [_dictionary setValue:object forKey:key];
            [_array addObject:key];
        } else {
            NSString *longTimeUnusedKey = [_array firstObject];
            [_dictionary setValue:nil forKey:longTimeUnusedKey];
            [_array removeObjectAtIndex:0];
            [_dictionary setValue:object forKey:key];
            [_array addObject:key];
        }
    } else {
        [_dictionary setValue:object forKey:key];
        [_array removeObject:key];
        [_array addObject:key];
    }
}

- (id)objectForKey:(NSString *)key
{
    if ([_array containsObject:key]) {
        [_array removeObject:key];
        [_array addObject:key];
        return [_dictionary objectForKey:key];
    } else {
        return nil;
    }
}

- (void)removeFirstObjectInCache{
    if (_array.count > 0) {
        NSString *key = [_array firstObject];
        UIViewController *vc = [_dictionary objectForKey:key];
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
        [_dictionary removeObjectForKey:key];
        [_array removeObject:key];
//        BPLog(@"删掉的key是:%@",key);
    }
}

- (NSInteger)totalVCCount{
    return _array.count;
}

@end
