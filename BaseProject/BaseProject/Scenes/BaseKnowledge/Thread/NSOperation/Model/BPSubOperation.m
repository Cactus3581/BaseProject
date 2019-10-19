//
//  BPSubOperation.m
//  BaseProject
//
//  Created by Ryan on 2019/1/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSubOperation.h"

/*
 
 如果使用子类 NSInvocationOperation、NSBlockOperation 不能满足日常需求，我们可以使用自定义继承自 NSOperation 的子类。可以通过重写 main 或者 start 方法 来定义自己的 NSOperation 对象。重写main方法比较简单，我们不需要管理操作的状态属性 isExecuting 和 isFinished。当 main 执行完返回的时候，这个操作就结束了。
 
 */
@implementation BPSubOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            BPLog(@"BPSubOperation：%@", [NSThread currentThread]);
        }
    }
}

@end
