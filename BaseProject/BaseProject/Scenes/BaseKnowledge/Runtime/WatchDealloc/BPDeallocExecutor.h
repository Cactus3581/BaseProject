//
//  BPDeallocExecutor.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/27.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BPDeallocExecutorBlock)(void);

@interface BPDeallocExecutor : NSObject

- (instancetype)initWithBlock:(BPDeallocExecutorBlock)block;

@end

NS_ASSUME_NONNULL_END
