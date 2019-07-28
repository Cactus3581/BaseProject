//
//  BPMultiDelegateCenter.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/28.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPDesignPatternsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPMultiDelegateCenter : NSObject

@property (nonatomic,weak) id <BPDesignPatternsProtocol> delegate;

+ (BPMultiDelegateCenter *)shareCenter;

- (void)test;

// 移除代理。一般不需要移除
- (void)removeDelegate:(id<BPDesignPatternsProtocol>)delegate;
- (void)removeAllDelegate;

@end

NS_ASSUME_NONNULL_END
