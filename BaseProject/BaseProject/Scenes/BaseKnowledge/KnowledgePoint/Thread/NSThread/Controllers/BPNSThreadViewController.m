//
//  BPNSThreadViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSThreadViewController.h"
#import "BPNSThread.h"
#import "BPSingleThreadTimer.h"

@interface BPNSThreadViewController ()
@property (nonatomic,strong) BPNSThreadTimer *thread;
@property (nonatomic,strong) BPSingleThreadTimer *singleThread;

@end

@implementation BPNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initThread];//正常情况
//    [self initThreadTimer];// 非单例常驻thread
    [self initSingleThreadTimer];// 单例常驻thread
//    [self initThreadTimerRunloop]; //无效方法
}

- (void)initThread {
    BPNSThread *thread = [[BPNSThread alloc] init];
}

- (void)initThreadTimer {
    self.thread = [[BPNSThreadTimer alloc] init];
}

- (void)initSingleThreadTimer {
    self.singleThread = [[BPSingleThreadTimer alloc] init];
}

- (void)initThreadTimerRunloop {
    BPNSThreadTimerRunloop *thread = [[BPNSThreadTimerRunloop alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    if (_thread) {
        [_thread.displayLink invalidate];
        _thread.displayLink = nil;
        _thread = nil;
    }
    
    if (_singleThread) {
        [_singleThread.displayLink invalidate];
        _singleThread.displayLink = nil;
        _singleThread = nil;
    }
    BPLog(@"%@ = dealloc",NSStringFromClass([self class]));
}

@end
