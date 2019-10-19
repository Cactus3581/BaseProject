//
//  BPProxy.h
//  BaseProject
//
//  Created by Ryan on 2019/6/26.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPProxy : NSProxy

- (instancetype)initWithObj:(id)obj;

// 在 Proxy里 只有声明
- (void)execute:(NSString *)text;

// 在 Proxy里 声明且实现了，可以调用
- (void)execute1:(NSString *)text;

- (void)execute2:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
