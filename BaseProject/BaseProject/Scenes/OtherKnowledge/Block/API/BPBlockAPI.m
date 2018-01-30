//
//  BPBlockAPI.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/24.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBlockAPI.h"

@implementation BPBlockAPI

- (void)handleBlock:(dispatch_block_t)failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        failure();
    });
}

- (void)setBlock:(successBlock)block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block(nil);
    });
}
@end
