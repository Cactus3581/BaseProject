//
//  BPBlockModel.m
//  BaseProject
//
//  Created by Ryan on 2018/1/24.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBlockModel.h"

typedef void (^Completion)(BPBlockModel *foo);

@interface BPBlockModel ()

@property (nonatomic, copy) Completion completion1;
@property (nonatomic, copy) Completion completion2;

@end
static NSInteger kTime = 5;

@implementation BPBlockModel


- (void)resolvePropertyBlock:(successBlock)block {
    _block = [block copy];
    //__block successBlock block1 = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test];
        _block = nil;
        // 或block1 = nil;
    });
}

- (void)handlePropertyBlock:(successBlock)block {
    _block = [block copy];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // dispatch_after 强持有了self
        [self test];
    });
}

- (void)test {
    if (_block) {
        _block(@{});
    }
}

- (void)handleBlock:(dispatch_block_t)block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

- (void)setBlock:(successBlock)block {
    _block = [block copy];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block(@{});
        }
    });
}

- (void)setSuccess:(NSString * (^)(NSString *str1))block1 fail:(void (^)(NSString *str2))block2 {
    NSString *str = block1(@"");//这是block的调用，函数指针指向block块，即实现块
    BPLog(@"%@",str);
    block2(@"");
}

- (void)foo {
    //利用了self 做参数传进 block 不会被 Block 捕获：多加一个参数，省掉两行代码”的效果。原理就是利用了“参数”的特性：参数是存放在栈中的(或寄存器中)，系统负责回收，开发者无需关心。因为解决问题的思路是：将 block 会捕获变量到堆上的问题，化解为了：变量会被分配到栈(或寄存器中)上，
    __weak typeof(self) weakSelf = self;
    self.completion1 = ^(BPBlockModel *foo) {
        BPLog(@"completion1");
    };
    self.completion2 = ^(BPBlockModel *foo) {
        __strong typeof(self) strongSelf = weakSelf;
        BPLog(@"completion2");
        NSUInteger delaySeconds = 3;
        dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
        dispatch_after(when, dispatch_get_main_queue(), ^{
            BPLog(@"两秒钟后");
            //strongSelf.completion1(foo); // 以下两种方式都可以
            foo.completion1(foo);//foo等价于strongSelf
            
        });
    };
    self.completion2(self);
}

- (void)dealloc {
    BPLog(@"model:dealloc");
}

@end
