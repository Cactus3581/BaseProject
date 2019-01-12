//
//  BPDeallocExecutor.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/27.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPDeallocExecutor.h"

@interface BPDeallocExecutor()

@property (nonatomic, copy) BPDeallocExecutorBlock deallocExecutorBlock;

@end

@implementation BPDeallocExecutor

- (instancetype)initWithBlock:(BPDeallocExecutorBlock)deallocExecutorBlock {
    self = [super init];
    if (self) {
        _deallocExecutorBlock = [deallocExecutorBlock copy];
    }
    return self;
}

- (void)dealloc {
    if (_deallocExecutorBlock) {
        _deallocExecutorBlock();
    }
//    !_deallocExecutorBlock ?: _deallocExecutorBlock();
}

@end
