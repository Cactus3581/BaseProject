//
//  BPBlockAPI.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/24.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBlockAPI.h"

@implementation BPBlockAPI

- (void)test {
    BPLog(@"BLOCK");
}

- (void)handleBlock1:(successBlock)block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block(nil);
    });
}

- (void)handleBlock:(dispatch_block_t)failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        failure();
    });
}

- (void)setBlock:(successBlock)block {
    __block successBlock block1 = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block(nil);
        block1 = nil;
    });
}

@end
