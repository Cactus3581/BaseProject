//
//  BPNSThread.m
//  BaseProject
//
//  Created by Ryan on 2018/3/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSThread.h"
#import "CADisplayLink+BPAdd.h"

@interface BPNSThread()
@property (nonatomic, strong) NSThread *thread;//常驻线程
@end

@implementation BPNSThread

- (instancetype)init {
    self = [super init];
    if (self) {
        [self startUpThread];
    }
    return self;
}

/**
 NSThread创建一个线程：不用gcd开辟常驻子线程，避免线程池满时，不一定会新建线程执行任务；
 */
- (void)startUpThread {
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureRunloop) object:nil] ;
    [self.thread setName:@"BPPermanentThread1"];
    [self.thread start];
    [self performSelector:@selector(update) onThread:self.thread withObject:nil waitUntilDone:NO];
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

/**
 *  在创建的thread上执行任务
 */
- (void)update {
    BPLog(@"isMainThread = %d",[NSThread isMainThread]);
}

- (void)dealloc {
    BPLog(@"%@ = dealloc",NSStringFromClass([self class]));
}

@end


@interface BPNSThreadTimer()
@property (nonatomic, strong) NSThread *thread;//常驻线程
@end

@implementation BPNSThreadTimer
- (instancetype)init {
    self = [super init];
    if (self) {
        [self startUpThread];
    }
    return self;
}

- (void)startUpThread {
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureRunloop) object:nil] ;
    [self.thread setName:@"BP_VolumeWaver_Thread"];
    [self.thread start];
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
        [weakSelf performSelector:@selector(updateMeters) onThread:self.thread withObject:nil waitUntilDone:NO];
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


@interface BPNSThreadTimerRunloop()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSThread *thread;//常驻线程
@property (nonatomic, strong) NSRunLoop *runLoop;
@end

@implementation BPNSThreadTimerRunloop

- (instancetype)init {
    self = [super init];
    if (self) {
        [self startUpThread];
    }
    return self;
}

- (void)startUpThread {
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureRunloop) object:nil] ;
    [self.thread setName:@"BP_VolumeWaver_Thread"];
    [self.thread start];
    [self startTimer];
}

/**
 *  添加runloop实现线程常驻
 */
- (void)configureRunloop {
    @autoreleasepool {
        self.runLoop = [NSRunLoop currentRunLoop];
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)startTimer {
    __weak typeof (self) weakSelf = self;

    self.displayLink = [CADisplayLink displayLinkWithRunLoop:[NSRunLoop currentRunLoop] executeBlock:^(CADisplayLink *displayLink) {
        //[weakSelf updateMeters];//此方法不可以，还是在主线程执行
        [weakSelf performSelector:@selector(updateMeters) onThread:weakSelf.thread withObject:nil waitUntilDone:NO];
    }];
    
    //以下方法不可以，获取不到runloop
//    if (self.runLoop) {
//        self.displayLink = [CADisplayLink displayLinkWithRunLoop:self.runLoop executeBlock:^(CADisplayLink *displayLink) {
//            [weakSelf updateMeters];
//            //[weakSelf performSelector:@selector(updateMeters) onThread:weakSelf.thread withObject:nil waitUntilDone:NO];
//        }];
//    }

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
