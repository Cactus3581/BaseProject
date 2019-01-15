//
//  BPRunloopViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/31.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRunloopViewController.h"

//http://geek.csdn.net/news/detail/55617
//http://geek.csdn.net/news/detail/56056

@interface BPRunloopViewController ()
@property (strong, nonatomic) NSThread *thread;
@end

@implementation BPRunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self runloop_workInStaticThread];//在常驻线程下工作
            }
                break;
                
            case 1:{
                [self runloop_timer];// Mode和Timer的使用
            }
                break;
                
            case 2:{
                [self runloop_leisure];//空闲时UIImageView赋值图片
            }
                break;
                
            case 3:{
                [self runloop_observer];//用来展示CFRunLoopObserverRef使用
            }
                break;

        }
    }
}
#pragma mark - 在常驻线程下工作
- (void)runloop_workInStaticThread {
    [self performSelector:@selector(test) onThread:[self runloop_staticThread] withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
}

//开启常驻线程：避免使用 GCD Global 队列来创建 Runloop 常驻线程。因为线程池可能会满，任务，无法执行，造成crash。
- (NSThread *)runloop_staticThread {
    static NSThread *runloopThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        runloopThread = [[NSThread alloc] initWithTarget:self selector:@selector(runloop_runloop:) object:nil];
        [runloopThread start];
    });
    return runloopThread;
}

- (void)runloop_runloop:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"runloop"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];//此处添加 port 只是为了让 RunLoop 不至于退出，并没有用于实际的发送消息。
        [runLoop run];
        
        // 测试是否开启了RunLoop，如果开启RunLoop，则来不了这里，因为RunLoop开启了循环。
        BPLog(@"开启RunLoop失败");
    }
}

#pragma mark - Mode和Timer的使用
/*
 scheduledTimerWithTimeInterval：系列的方法默认将timer添加到runloop里，mode默认是NSDefaultRunLoopMode；
 timerWithTimeInterval： 必须手动添加到runloop里，手动更改mode
 */
- (void)runloop_timer {
    NSTimer *timer;
    timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:NO];
    
    // 调用了scheduledTimer返回的定时器，已经自动被加入到了RunLoop的NSDefaultRunLoopMode模式下。
    //timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:NO];

    
    // iOS 10 以后的新API，解决了循环引用的bug
    if (@available(iOS 10,*)) {
        /*
         // 必须手动添加到runloop里
         timer = [NSTimer timerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
         
         }];
         
         // 默认加到runloop里
         timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
         
         }];
         */
    }
    
    // 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下,一旦RunLoop进入其他模式，定时器timer就不工作了
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // 将定时器添加到当前RunLoop的UITrackingRunLoopMode下，只在拖动情况下工作
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // 将定时器添加到当前RunLoop的NSRunLoopCommonModes下，定时器就会跑在被标记为Common Modes的模式下
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [timer fire]; //立即触发该定时器，否则就是设定的时间之后运行
}

#pragma mark - 空闲时UIImageView赋值图片
- (void)runloop_leisure {
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scroll];
    [scroll setContentSize:CGSizeMake(self.view.width, 1000)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    imageView.backgroundColor = kThemeColor;
    [self.view addSubview:imageView];
    
    [imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"naviBarBackGroundImage"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
}

#pragma mark - 用来展示CFRunLoopObserverRef使用
- (void)runloop_observer {
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {

            case kCFRunLoopEntry:
                BPLog(@"即将进入Loop");
                break;
                
            case kCFRunLoopBeforeTimers:
                BPLog(@"即将处理 Timer");
                break;
                
            case kCFRunLoopBeforeSources:
                BPLog(@"即将处理 Source");
                break;
                
            case kCFRunLoopBeforeWaiting:
                BPLog(@"即将进入休眠");
                break;
                
                
            case kCFRunLoopAfterWaiting:
                BPLog(@"刚从休眠中唤醒");
                break;
                
                
            case kCFRunLoopExit:
                BPLog(@"即将退出Loop");
                break;
                
                
            case kCFRunLoopAllActivities:
                BPLog(@"所有活动，不知道这个type是什么意思");
                break;
        }
    });
    
    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // 释放observer
    CFRelease(observer);
}

- (void)test {
    BPLog(@"_%@_%d",BPThread);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
