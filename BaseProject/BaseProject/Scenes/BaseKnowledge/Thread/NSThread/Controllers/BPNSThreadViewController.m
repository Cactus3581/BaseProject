//
//  BPNSThreadViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/3/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSThreadViewController.h"
#import "BPNSThread.h"
#import "BPSingleThreadTimer.h"

@interface BPNSThreadViewController ()
@property (nonatomic,strong) BPNSThreadTimer *thread;
@property (nonatomic,strong) BPSingleThreadTimer *singleThread;
@property (nonatomic,assign) NSInteger ticketSurplusCount;

@end

@implementation BPNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initThread];//正常情况
//    [self initThreadTimer];// 非单例常驻thread
//    [self initSingleThreadTimer];// 单例常驻thread
//    [self initThreadTimerRunloop]; //无效方法
}

- (void)initThread {
    BPNSThread *thread1 = [[BPNSThread alloc] init];
    // 1.1 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@" start 1"];
    // 1.2 启动线程，系统把线程对象放入可调度线程池中，线程对象进入就绪状态。
    [thread start]; // 线程启动后，就会在线程thread中执行self的run方法。当线程任务执行完毕，自动进入死亡状态
    [self performSelector:@selector(run:) onThread:thread withObject:@" start 2" waitUntilDone:YES];
    
    // 2. 创建线程后自动启动线程
    //[NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:nil];

    // 3. 隐式创建并启动线程
    //[self performSelectorInBackground:@selector(run:) withObject:nil];
}

// 新线程调用方法，里边为需要执行的任务
- (void)run:(NSString *)text {
    NSLog(@"text = %@,%@",text,[NSThread currentThread]);
}

#pragma mark - 线程状态控制方法
- (void)baseUseAPI {
    
    // 1. 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    // 2. 启动线程
    [thread start]; // 线程启动后，就会在线程thread中执行self的run方法。当线程任务执行完毕，自动进入死亡状态
    
    // 获得主线程
    [NSThread mainThread];
    
    // 判断是否为主线程(对象方法)
    [thread isMainThread];
    
    // 判断是否为主线程(类方法)
    [NSThread isMainThread];
    
    
    // 获得当前线程
    NSThread *currentThread = [NSThread currentThread];
    
    // 线程的名字——setter方法
    [thread setName:@""];
    
    // 线程的名字——getter方法
    NSString *name = [thread name];
    
    // 阻塞（暂停）线程方法
    // 阻塞（暂停）线程方法
    [NSThread sleepUntilDate:nil];
    [NSThread sleepForTimeInterval:0];

    // 强制停止线程
    [NSThread exit];
}

#pragma mark - 线程之间的通信
- (void)threadsSend {
    NSThread *thread = [NSThread currentThread];

    // 在主线程上执行操作
    [self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:YES modes:@[NSRunLoopCommonModes]];
    
    // 在指定线程上执行操作
    [self performSelector:@selector(run) onThread:thread withObject:nil waitUntilDone:YES modes:@[NSRunLoopCommonModes]];
    [self performSelector:@selector(run) onThread:thread withObject:nil waitUntilDone:YES];
    
    // 在当前线程上执行操作，调用 NSObject 的 performSelector:相关方法
    [self performSelector:@selector(run)];
    [self performSelector:@selector(run) withObject:nil];
    [self performSelector:@selector(run) withObject:nil withObject:nil];
}

#pragma mark - 线程的状态转换:就绪，运行，阻塞，死亡
- (void)threadsStatus {
    
}

#pragma mark - 多线程安全
/**
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)initTicketStatusSave {
    // 1. 设置剩余火车票为 50
    self.ticketSurplusCount = 50;
    
    // 2. 设置北京火车票售卖窗口的线程
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
     thread1.name = @"北京火车票售票窗口";
    
    // 3. 设置上海火车票售卖窗口的线程
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    thread2.name = @"上海火车票售票窗口";
    
    // 4. 开始售卖火车票
    [thread1 start];
    [thread2 start];
    
}

// 售卖火车票(线程安全)
- (void)saleTicketSafe {
    while (1) {
        // 互斥锁
        @synchronized (self) {
            //如果还有票，继续售卖
            if (self.ticketSurplusCount > 0) {
                self.ticketSurplusCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                NSLog(@"所有火车票均已售完");
                break;
            }
        }
    }
}

- (void)initThread2 {
    // 1. 创建线程后自动启动线程
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

- (void)initThread3 {
    // 1. 隐式创建并启动线程
    [self performSelectorInBackground:@selector(run) withObject:nil];
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
