//
//  NSObject+BPCustomKVO.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/30.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BPObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BPCustomKVO)

- (void)bp_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(BPObservingBlock)block;

- (void)bp_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
