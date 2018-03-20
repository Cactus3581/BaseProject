//
//  BPWeakView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPWeakView.h"

@implementation BPWeakView

- (void)setSuccess:(NSString * (^)(NSString *str1))block1 fail:(void (^)(NSString *str2))block2 {
    NSString *str =  block1(@"");//这是block的调用，函数指针指向block块，即实现块
    BPLog(@"%@",str);
    block2(@"");
}

+ (void)setBlock2:(weakViewBlock)block1 block2:(dispatch_block_t)block2 {
    block2();//这是block的调用，函数指针指向block块，即实现块
}

+ (void)setBlock3:(id)obj block:(dispatch_block_t)block {
    block();//这是block的调用，函数指针指向block块，即实现块

}
- (void)dealloc {
    
}

@end
