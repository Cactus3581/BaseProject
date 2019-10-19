//
//  BPRunloopViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/12/31.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRunloopViewController.h"
#import "BPRunloopHelper.h"


void runloopSourceScheduleRoutine(void *info, CFRunLoopRef runloop, CFRunLoopMode mode) {
    NSLog(@"Schedule routine: source is added to runloop");
}

void runloopSourceCancelRoutine(void *info, CFRunLoopRef runloop, CFRunLoopMode mode) {
    NSLog(@"Cancel Routine: source removed from runloop");
}

void runloopSourcePerformRoutine(void *info) {
    NSLog(@"In thread [%@], Perform Routine: source has fired", [NSThread currentThread].name);
}

static CFDataRef Callback(CFMessagePortRef port,SInt32 messageID,CFDataRef data,void *info) {
    // ...
    NSLog(@"onRecvMessageCallBack is called");
    NSString *strData = nil;
    if (data) {
        const UInt8  *recvedMsg = CFDataGetBytePtr(data);
        strData = [NSString stringWithCString:(char *)recvedMsg encoding:NSUTF8StringEncoding];
        /**
         
         实现数据解析操作
         
         **/
        
        NSLog(@"receive message:%@",strData);
    }
    
    //为了测试，生成返回数据
    NSString *returnString = [NSString stringWithFormat:@"i have receive:%@",strData];
    const char* cStr = [returnString UTF8String];
    NSUInteger ulen = [returnString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    CFDataRef sgReturn = CFDataCreate(NULL, (UInt8 *)cStr, ulen);
    return sgReturn;
}

@interface BPRunloopViewController ()<NSMachPortDelegate>

@property (weak, nonatomic) NSThread *thread;
@property (strong, nonatomic) NSPort *port;
@property (strong, nonatomic) NSRunLoop *runLoop;
@property (assign, nonatomic) CFRunLoopSourceRef source;
@property (assign, nonatomic) CFRunLoopRef cfRunloop;
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
                [self runloop_run];//开启
            }
                break;
                
            case 1:{
                [self runloop_performSelector];// performSelector
            }
                break;
                
            case 2:{
                [self runloop_timer];// Mode和Timer的使用

            }
                break;
                
            case 3:{
                [self runloop_workInStaticThread];//在常驻线程下工作
                break;
            }
                
            case 4:{
                [self runloop_downloadImage];//空闲时UIImageView赋值图片
                break;
            }
                
            case 5:{
                [self addSource0];//
                break;
            }
                
            case 6:{
                [self addCustomPort];//
                break;
            }
                
            case 7:{
                [self runloop_ipc];//线程间使用Port通信
                break;
            }
                
            case 8:{
                [self change];//考点
            }
                break;
        }
    }
}

#pragma mark - runloop的创建，有三种方法：分别注意 [NSRunLoop currentRunLoop] 和 run 的位置

- (void)runloop_run {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 50)];
    [button addTarget:self action:@selector(stopThreadAction) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button];
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    _thread = thread;
    [thread setName:@"com.cactus.thread"];
    [thread start];
    BPLog(@"创建子线程并执行");
//    [self performSelector:@selector(handleInSubThread:) onThread:thread withObject:@"在子线程下执行任务" waitUntilDone:YES];
//    [self performSelector:@selector(handleInSubThread:) onThread:thread withObject:@"在子线程下执行任务" waitUntilDone:NO];
    BPLog(@"主线程函数出栈");
}

- (void)run {
    @autoreleasepool {
        BPLog(@"创建 runLoop");

        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        // 添加一个端口作为输入源，执行完，runloop 不会退出，需要手动销毁
        // [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        
        // 添加一个 Selector 作为输入源，执行完，runloop 自动会退出
         [self performSelector:@selector(handleInSubThread:) withObject:@"run" afterDelay:0];
        
        // 开启Run方法，在Run方法之前必须添加Source。
        
        // 默认为NSDefaultRunLoopMode模式，没有超时限制，一旦开启，无法使Runloop退出
         [runLoop run];
        
        // 默认为NSDefaultRunLoopMode模式，参数为超时时间（随机返回一个比较遥远的未来时间），超时就退出，否则不退出。
        
        // [_runLoop runUntilDate:[NSDate distantFuture]];
        
        // 超时 || source被处理，Runloop就会退出，否则不退出
        // result为YES表示是处理事件后返回的，NO表示是超时或者停止运行导致返回的
        
        // BOOL result = [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        BPLog(@"runloop已成功退出");
    }
    BPLog(@"autoreleasepool 之后");
}

- (void)stopThreadAction {
    [self performSelector:@selector(stopThread) onThread:_thread withObject:nil waitUntilDone:YES];
}

- (void)handleInSubThread:(NSString *)text {
    NSLog(@"handleInSubThread text = %@",text);
}

#pragma mark - runloop的退出
/*
 1. 设置超时时间
 2. 销毁对应线程
 3. 调用stop函数
 4. 移除source：系统内部有可能会在当前线程的runloop中添加一些输入源，所以通过手动移除input source或者timer这种方式，并不能保证runloop一定会退出。
 */
- (void)stopThread {
    BPLog(@"移除 Thread 和 Runloop");
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSThread *thread = [NSThread currentThread];
    [thread cancel];
    
    // 将当前线程的runloop中的port移除
    // [_runLoop removePort:_port forMode:NSDefaultRunLoopMode];
}

#pragma mark - performSelector
- (void)runloop_performSelector {
    BPLog(@"1");
    
    // NSRunloop 类提供selector方法：
    // 1,3,2
    [self performSelector:@selector(testPerformSelector) withObject:nil afterDelay:0];

    // NSObject类提供selector方法：
    // 1,2,3
    [self performSelector:@selector(testPerformSelector)];
    
    // 1,2,3
    [self performSelector:@selector(testPerformSelector) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
    
    // 1,3,2
    [self performSelector:@selector(testPerformSelector) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    
    BPLog(@"3");
}

- (void)testPerformSelector {
    BPLog(@"2");
}

#pragma mark - NSTimer

- (void)runloop_timer {
    
    NSTimer *timer;
    
    // 必须手动添加到runloop里
    timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(testTimer) userInfo:nil repeats:YES];
    
    // 自动被加入到了loop的NSDefaultRunLoopMode模式下
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(testTimer) userInfo:nil repeats:YES];
    
    
    // iOS 10 以后的新API，解决了循环引用的bug
    if (@available(iOS 10,*)) {
        
        // 必须手动添加到runloop里
        timer = [NSTimer timerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
        }];
        
        // 默认加到runloop里
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
        }];
    }
    
    // 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下,一旦RunLoop进入其他模式，定时器timer就不工作了
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // 将定时器添加到当前RunLoop的UITrackingRunLoopMode下，只在拖动情况下工作
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // 将定时器添加到当前RunLoop的NSRunLoopCommonModes下，定时器就会跑在被标记为Common Modes的模式下
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [timer fire]; //立即触发该定时器，否则就是设定的时间之后运行
}

- (void)testTimer {
}

#pragma mark - 在常驻线程下工作
- (void)runloop_workInStaticThread {
    
    static NSThread *thread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        thread = [[NSThread alloc] initWithTarget:self selector:@selector(startRunloop:) object:nil];
        [thread start];
    });
    
    // 当需要这个后台线程执行任务时，通过调用 [NSObject performSelector:onThread:..] 将这个任务扔到后台线程的 RunLoop 中。
    [self performSelector:@selector(testRunloop_workInStaticThread) onThread:thread withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
}

- (void)testRunloop_workInStaticThread {
    BPLog(@"_%@_%d",BPThread);
}

//开启常驻线程：避免使用 GCD Global 队列来创建 Runloop 常驻线程。因为线程池可能会满，任务，无法执行，造成crash。
- (void)startRunloop:(id)object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"runloop"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];//此处添加 port 只是为了让 RunLoop 不至于退出，并没有用于实际的发送消息。
        [runLoop run];
        // 测试是否开启了RunLoop，如果开启RunLoop，则来不了这里，因为RunLoop开启了循环。
        BPLog(@"开启RunLoop失败");
    }
}


#pragma mark - 空闲时UIImageView赋值图片
- (void)runloop_downloadImage {
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scroll];
    [scroll setContentSize:CGSizeMake(self.view.width, 1000)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    imageView.backgroundColor = kThemeColor;
    [self.view addSubview:imageView];
    
    [imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"module_landscape3"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
}


#pragma mark - 自定义source0

- (void)addSource0 {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 50)];
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button];
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(startRunloop1:) object:nil];
    _thread = thread;
    [self.thread start];
    
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        NSLog(@"timer tick");
    //    }];
    //    [self runloop_observer];
}

- (void)startRunloop1:(id)object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"runloop"];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        self.cfRunloop = [runloop getCFRunLoop];
        CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL, runloopSourceScheduleRoutine, runloopSourceCancelRoutine, runloopSourcePerformRoutine };
        // 创建source0
        self.source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
        // 添加source0到相应的RunloopMode
        CFRunLoopAddSource(self.cfRunloop, self.source, kCFRunLoopDefaultMode);
        [self runloop_observer];
        [runloop run];
    }
}

// 需要手动触发
- (void)buttonTapped {
    CFRunLoopSourceSignal(self.source);
    CFRunLoopWakeUp(self.cfRunloop);
}

#pragma mark - 自定义 CFMessagePort (Source1)

// CFMessagePort确实非常适合用于简单的一对一通讯。简简单单几行代码，一个本地端口就被附属到runloop源上，只要获取到消息就执行回调
// 消息接收者需要通过以下方式注册消息监听：

- (void)addCustomPort {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 50)];
    [button addTarget:self action:@selector(sendPortRequest) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button];
    
    // 创建基于端口的source1
    // 创建接收端口，用于监听端口，其中callBack为回调方法，类型为CFMessagePortCallBack
    CFMessagePortRef localPort = CFMessagePortCreateLocal(kCFAllocatorDefault,CFSTR("com.example.app.port.server"),Callback,nil,nil);
    // 创建端口输入源
    CFRunLoopSourceRef source = CFMessagePortCreateRunLoopSource(kCFAllocatorDefault, localPort, 0);
    // 添加端口输入源
    
    CFRunLoopAddSource(CFRunLoopGetCurrent(),source,kCFRunLoopCommonModes);
}

// 发送数据：Source1可以监听系统端口和其他线程相互发送消息，主动唤醒RunLoop
- (void)sendPortRequest {
    
    // 生成Remote port
    CFMessagePortRef remotePort = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR("com.example.app.port.server"));
    if (nil == remotePort) {
        NSLog(@"remotePort create failed");
        return;
    }
    
    // 构建发送数据（string）
    SInt32 messageID = 0x1111; // Arbitrary
    CFTimeInterval timeout = 10.0;
    NSString *msg = @"cactus";
    const char *message = [msg UTF8String];
    CFDataRef data,recvData = nil;
    data = CFDataCreate(NULL, (UInt8 *)message, strlen(message));
    
    // 执行发送操作
    SInt32 status = CFMessagePortSendRequest(remotePort, messageID, data, timeout,timeout,kCFRunLoopDefaultMode, &recvData);
    
    if (status == kCFMessagePortSuccess) {
        // ...
    }
    
    if (!recvData) {
        NSLog(@"recvData date is nil.");
        CFRelease(data);
        CFMessagePortInvalidate(remotePort);
        CFRelease(remotePort);
        return ;
    }
    
    // 解析返回数据
    const UInt8  *recvedMsg = CFDataGetBytePtr(recvData);
    if (!recvedMsg) {
        NSLog(@"receive date err.");
        CFRelease(data);
        CFMessagePortInvalidate(remotePort);
        CFRelease(remotePort);
        return ;
    }
    
    NSString *strMsg = [NSString stringWithCString:(char *)recvedMsg encoding:NSUTF8StringEncoding];
    NSLog(@"%@",strMsg);
    
    CFRelease(data);
    CFMessagePortInvalidate(remotePort);
    CFRelease(remotePort);
    CFRelease(recvData);
    
    BPLog(@"%@",strMsg);
}

// 取消端口监听
- (void)removePort {
    //    CFMessagePortInvalidate(localPort);
    //    CFRelease(localPort);
}

#pragma mark - iOS线程间的通信

//iOS中，两个线程之间要想互相通信，可以使用：NSMachPort
- (void)runloop_ipc {
    //1. 创建主线程的port
    // 子线程通过此端口发送消息给主线程
    NSPort *port = [NSMachPort port];
    
    //2. 设置port的代理回调对象
    port.delegate = self;
    
    //3. 把port加入runloop，接收port消息
    [[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
    
    //4. 启动子线程,并传入主线程的port
    BPRunloopHelper *work = [[BPRunloopHelper alloc] init];
    [NSThread detachNewThreadSelector:@selector(launchThreadWithPort:) toTarget:work withObject:port];
}

// NSPortDelegate
- (void)handlePortMessage:(NSMessagePort*)message {
    
    NSLog(@"接到子线程传递的消息！%@",message);
    
    //1. 消息id
    NSUInteger msgId = [[message valueForKeyPath:@"msgid"] integerValue];
    
    //2. 当前主线程的port
    NSPort *localPort = [message valueForKeyPath:@"localPort"];
    
    //3. 接收到消息的port（来自其他线程）
    NSPort *remotePort = [message valueForKeyPath:@"remotePort"];
    
    if (msgId == kMsg1) {
        //向子线的port发送消息
        [remotePort sendBeforeDate:[NSDate date]
                             msgid:kMsg2
                        components:nil
                              from:localPort
                          reserved:0];
        
    } else if (msgId == kMsg2){
        NSLog(@"操作2....\n");
    }
}

#pragma mark - 考点
- (void)change {
    [self change1];
    [self change2];
}

- (void)change1 {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BPLog(@"1");
        [self performSelector:@selector(changeTest:) onThread:[NSThread currentThread] withObject:@"3" waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
        
        [self performSelector:@selector(changeTest:) onThread:[NSThread currentThread] withObject:@"4" waitUntilDone:NO ];
        
        [self performSelector:@selector(changeTest:) withObject:@"5" afterDelay:0];
        BPLog(@"2");
    });
}

- (void)changeTest:(NSString *)text {
    BPLog(@"%@",text);
}

- (void)change2 {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"1");
        // 先添加sourcem，再run，否则 runloop会因为没有 mode item 而退出。（下面的两句话如果颠倒过来，test会不执行）
        [self performSelector:@selector(changeTest:) withObject:@"6" afterDelay:10];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"2");
    });
}

// 保证子线程数据回来更新UI的时候不打断用户的滑动操作:等用户不再滑动页面，主线程RunLoop由UITrackingRunLoopMode切换到NSDefaultRunLoopMode时再去更新UI

- (void)change3 {
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
}

#pragma mark - Observer
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.source = NULL;
    self.cfRunloop = NULL;
}

@end
