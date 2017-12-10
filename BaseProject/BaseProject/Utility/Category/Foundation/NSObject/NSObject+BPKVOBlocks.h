//
//  NSObject+KVOBlocks.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BPKVOBlock)(NSDictionary *change, void *context);

@interface NSObject (BPKVOBlocks)

- (void)_addObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
          withBlock:(BPKVOBlock)block;

-(void)_removeBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath;

-(void)_addObserverForKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
                     context:(void *)context
                   withBlock:(BPKVOBlock)block;

-(void)_removeBlockObserverForKeyPath:(NSString *)keyPath;

@end
