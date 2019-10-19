//
//  BPMulticastDelegate.h
//  BaseProject
//
//  Created by Ryan on 2019/7/28.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPMulticastDelegate : NSProxy

@property (nonatomic,weak) id delegate;

// 移除代理。一般不需要移除

- (void)removeDelegate:(id)delegate;

- (void)removeAllDelegate;

@end

NS_ASSUME_NONNULL_END
