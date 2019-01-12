//
//  NSObject+BPDeallocBlockExecutor.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/27.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPDeallocExecutor.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^BPDeallocSelfCallback)(__unsafe_unretained id owner, NSUInteger identifier);

@interface NSObject (BPDeallocBlockExecutor)

- (void)bp_executeAtDealloc:(BPDeallocExecutorBlock)block;

//- (void)bp_executeAtDealloc:(BPDeallocExecutorBlock)block __attribute__((deprecated("Deprecated in 1.2.0. Use `-bp_willDeallocWithSelfCallback:` instead.")));

@end

NS_ASSUME_NONNULL_END
