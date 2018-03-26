//
//  BPSingleThreadTimer.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPSingleThreadTimer.h"
#import "CADisplayLink+BPAdd.h"

@interface BPSingleThreadTimer()
@end

static NSThread *thread;
@implementation BPSingleThreadTimer
- (instancetype)init {
    self = [super init];
    if (self) {
        [self startUpThread];
    }
    return self;
}

- (void)startUpThread {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureRunloop) object:nil] ;
        [thread setName:@"KS_VolumeWaver_Thread"];
        [thread start];
    });
    [self startTimer];
}

/**
 *  添加runloop实现线程常驻
 */
- (void)configureRunloop{
    @autoreleasepool {
        //添加port源，保证runloop正常轮询，不会创建后直接退出。
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        //开启runloop
        [[NSRunLoop currentRunLoop] run];
    }
}

#pragma mark - 开启定时器，开始进行波浪动画（通过时时更新异步绘制来实现的）
- (void)startTimer {
    __weak typeof (self) weakSelf = self;
    self.displayLink = [CADisplayLink displayLinkWithRunLoop:[NSRunLoop currentRunLoop] executeBlock:^(CADisplayLink *displayLink) {
        //[weakSelf updateMeters];//此方法不可以，还是在主线程执行
        [weakSelf performSelector:@selector(updateMeters) onThread:thread withObject:nil waitUntilDone:NO];
    }];
}

- (void)updateMeters {
    BPLog(@"isMainThread = %d",[NSThread isMainThread]);
}

- (void)dealloc {
    BPLog(@"%@ = dealloc",NSStringFromClass([self class]));
    [_displayLink invalidate];
    _displayLink = nil;
}

@end

