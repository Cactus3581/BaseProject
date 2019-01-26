//
//  BPGCDViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPGCDViewController.h"
#import "AFHTTPSessionManager.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <QuartzCore/QuartzCore.h>

//http://blog.csdn.net/jenny8080/article/details/52094140
//https://www.cnblogs.com/diyingyun/archive/2011/12/04/2275229.html
//http://www.dreamingwish.com/article/the-ios-multithreaded-programming-guide-4-thread-synchronization.html
//http://geek.csdn.net/news/detail/54092
//http://blog.csdn.net/x32sky/article/details/50736578

/*
 1. 线程，任务，队列，runloop，甚至是异步、并发的概念理解
 2. GCD的内部实现原理
 */

@interface BPGCDViewController ()
@property (nonatomic,strong) dispatch_semaphore_t semaphore; // 测试崩溃

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSArray *array;
@end

@implementation BPGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self gcd_general]; // 基本使用
            }
                break;
                
            case 1:{
                [self gcd_cancel]; // 取消任务
            }
                break;
                
            case 2:{
                [self gcd_deadlock]; // 死锁

            }
                break;
                
            case 3:{
                [self gcd_apply];//遍历;
            }
                break;
                
            case 4:{
                [self gcd_initTimer];//倒计时

            }
                break;
                
            case 5:{
                [self gcd_once];//dispatch_once
            }
                break;
                
            case 6:{
                [self gcd_after];//延长执行
            }
                break;
                
            case 7:{
                [self gcd_switchover];//线程通信
            }
                break;
                
                
            case 8:{
                [self gcd_group];//队列组：单层异步
            }
                break;
                
            case 9:{
                [self gcd_deep_group];//队列组：多层异步
            }
                break;
                
            case 10:{
                [self gcd_barrier];//栅栏
            }
                break;
                
            case 11:{
                [self gcd_signal_sync];//使用信号量进行同步操作
            }
                break;
                
            case 12:{
                [self gcd_group_signal];//信号量
            }
                break;
                
            case 13:{
                [self gcd_signal_dependAction];//信号量依赖
            }
                break;
                
            case 14:{
                [self gcd_signal_bug];// 信号量源个数导致的bug
            }
                break;
                
            case 15:{
                [self gcd_set_specific];//向指定队列里面设置一个标识
            }
                break;
                
            case 16:{
                [self gcd_set_target_queue];//变更队列优先级
            }
                break;
                
            case 17:{
                [self gcd_set_target_moreQueue];//设置目标队列：队列添加到目标队列
            }
                break;
                
            case 18:{
                [self change];//面试题
            }
                break;
        }
    }
}

#pragma mark - 一般使用：同步异步函数；串行并行队列
/*
 
 在主队列主线程的环境下：
 
 同步主队列：死锁;
 同步全局或者自定义并行队列：虽然是全局队列，但是同步函数会一个任务一个任务的执行，相当于串行执行。
 同步自定义串行对列：主线程去自定义串行执行任务，任务完成，返回。
 
 异步主队列：主队列里只有主线程，不会开辟子线程，，串行执行。
 异步全局或者是自定义并发队列：开辟子线程。
 异步自定义串行队列：自定义串行队列开辟仅一个线程，串行执行。
 
 注意：
 1. 串行队列（包括主队列）里至多1个线程。
 2. 主队列的特殊性：所有放在主队列中的任务都会在主线程上执行，据此可得，主队列中，即使有异步任务，也会依次在主线程上执行，一般在回到主线程的例子中：任务放到主队列的后面，因为主队列是串行队列，等主线程上的前面的代码执行完，所以异步函数里的任务会等主线程上的任务执行完再执行。
 
 同步：
 1. 阻塞当前队列的线程：不让它在同步函数任务所在的线程在当前队列中执行，并不是说不让线程在其他队列执行;
 2. 需要等待任务返回；
 3. 不会开辟线程；
 
 异步：
 1. 不阻塞当前线程;
 2. 不需要等待任务返回；
 3. 可能会开辟线程；
 
 并发并行
 */

#pragma mark - 创建队列(自定义创建串行队列和并行队列，获取系统队列)

- (void)gcd_general {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL); // 串行队列，null = DISPATCH_QUEUE_SERIAL
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue = globalQueue;
    
    dispatch_sync(queue, ^{
        [self testEventWithData:0];
        BPLog(@"sync7_%@_%d",BPThread);
    });
    
    dispatch_async(queue, ^{
        [self testEventWithData:0];
        BPLog(@"sync7_%@_%d",BPThread);
    });
}

- (void)testEventWithData:(NSInteger)limit {
    for (int i = 0; i<limit; i++) {
        NSNumber *number = @(i);
        //BPLog(@"%@",number);
    }
}

#pragma mark - 取消任务
- (void)gcd_cancel {
    [self gcd_block_cancel];
    [self gcd_extern_var];//通过定义外部变量，判断是否进行，否就return
    [self gcd_block_suspend];
}

/*
 1.iOS8后的api
 2.必须用dispatch_block_create创建dispatch_block_t任务
 3.dispatch_block_cancel也只能取消尚未执行的任务，对正在执行的任务不起作用。也就是说此方法具有不确定性
 */
- (void)gcd_block_cancel {
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.gcdtest.www", DISPATCH_QUEUE_CONCURRENT);

    dispatch_block_t block1 = dispatch_block_create(0, ^{
        BPLog(@"block1 %@",[NSThread currentThread]);
    });
    
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        sleep(5);
        BPLog(@"block2 %@",[NSThread currentThread]);
    });
    
    dispatch_block_t block3 = dispatch_block_create(0, ^{
        BPLog(@"block3 %@",[NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, block1); // 添加到队列里去
    dispatch_async(concurrentQueue, block2); // 添加任务到队列
    
    dispatch_block_cancel(block1);// success cancel
    NSInteger block1Result =  dispatch_block_testcancel(block1);//测试给定的分派块是否被取消。
    if (block1Result) {
        BPLog(@"block1取消成功");
    }else {
        BPLog(@"block1取消失败");
    }
    
    dispatch_block_cancel(block2);// success cancel
    NSInteger block2Result =  dispatch_block_testcancel(block2);//测试给定的分派块是否被取消。
    if (block2Result) {
        BPLog(@"block2取消成功");
    }else {
        BPLog(@"block2取消失败");
    }
    
    dispatch_block_cancel(block3);// success cancel
    NSInteger block3Result =  dispatch_block_testcancel(block3);//测试给定的分派块是否被取消。
    if (block3Result) {
        BPLog(@"block3取消成功");
    }else {
        BPLog(@"block3取消失败");
    }
    dispatch_async(concurrentQueue, block3); // 添加任务到队列
}

- (void)gcd_extern_var {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __block BOOL isCancel = NO;
    
    dispatch_async(queue, ^{
        BPLog(@"任务1 %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        BPLog(@"任务2 %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        BPLog(@"任务3 %@",[NSThread currentThread]);
        isCancel = YES;
    });
    
    dispatch_async(queue, ^{
        // 模拟：线程等待3秒，确保任务003完成 isCancel＝YES
        sleep(3);
        if(isCancel){
            BPLog(@"任务4已被取消 %@",[NSThread currentThread]);
        }else{
            BPLog(@"任务4 %@",[NSThread currentThread]);
        }
    });
}

//suspend只是挂起当前队列，但还不是取消，dispatch_suspend并不会立即暂停正在运行的block，而是在当前block执行完成后，暂停后续的block执行。
- (void)gcd_block_suspend {
    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd", DISPATCH_QUEUE_SERIAL);
    //提交第一个block，延时5秒打印。
    dispatch_async(queue, ^{
        sleep(5);
        BPLog(@"After 5 seconds...");
    });
    //提交第二个block，也是延时5秒打印
    dispatch_async(queue, ^{
        sleep(5);
        BPLog(@"After 5 seconds again...");
    });
    //延时一秒
    BPLog(@"sleep 1 second...");
    sleep(1);
    
    //挂起队列
    BPLog(@"suspend...");
    dispatch_suspend(queue);
    
    //延时10秒
    BPLog(@"sleep 10 second...");
    sleep(10);
    
    //恢复队列
    BPLog(@"resume...");
    dispatch_resume(queue);
}

#pragma mark - 栅栏
- (void)gcd_barrier {
    /*
     需求点：将异步任务分成两组：当第一组异步任务都执行完成后才执行第二组的异步任务，在两组任务之间形成“栅栏”，使其“下方”的异步任务在其“上方”的异步任务都完成之前是无法执行的。
     
     注意点1:栅栏只能跟自定义并行队列一块使用，globalQueue不起作用,所以栅栏不能跟globalQueue一块使用；
     注意点2:dispatch_barrier_async和dispatch_barrier_sync的区别：是否阻塞的区别；
     注意点3:与group点区别，barrier作用是将两个组分开；group的作用是组合成一个组
     */
    dispatch_queue_t concurrentQueue = dispatch_queue_create("barrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); // 注意：globalQueue不起作用,所以栅栏不能跟globalQueue一块使用

    dispatch_queue_t queue = concurrentQueue;

    dispatch_async(queue, ^{
        [self testEventWithData:10];
        BPLog(@"1_%@_%d",BPThread);
    });

    dispatch_async(queue, ^{
        [self testEventWithData:100];
        BPLog(@"2_%@_%d",BPThread);
    });
    

    BPLog(@"barrieri前");

    dispatch_barrier_sync(queue, ^{ // 同步阻塞
        BPLog(@"3_%@_%d",BPThread);
        [self testEventWithData:0];
    });
    // 非阻塞
    //    dispatch_barrier_async(queue, ^{
    //        [self testEventWithData:0];
    //        BPLog(@"3_%@_%d",BPThread);
    //    });
    BPLog(@"barrier后");

    dispatch_async(queue, ^{
        [self testEventWithData:200];
        BPLog(@"4_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        [self testEventWithData:50];
        BPLog(@"5_%@_%d",BPThread);
    });
    BPLog(@"方法栈弹出");
}

#pragma mark - 线程组：Dispatch Group的本质是一个初始value为LONG_MAX的semaphore，通过信号量来实现一组任务的管理，等待group中的任务完成其实是等待value恢复初始值
/*
 dispatch_group_create：创建一个信号量
 dispatch_group_enter：信号量的计数减去1；
 dispatch_group_leave：信号量的计数加上1；
 dispatch_group_wait
 dispatch_group_notify
 dispatch_group_async
 */
// 队列组：单层异步
- (void)gcd_group {
    /*
     需求点：执行多个耗时的异步任务，但是只能等到这些任务都执行完毕后，才能在主线程执行某个任务。
     */
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        [self testEventWithData:2000];
        BPLog(@"1_%@_%d",BPThread);
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self testEventWithData:10];
        BPLog(@"2_%@_%d",BPThread);
    });
    
    // 非阻塞
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...
        BPLog(@"3_%@_%d",BPThread);
    });
    
    // 阻塞
    //dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC)); //如果超过了指定时间或者是在指定时间内执行任务，可以i继续往下执行，否则就长久阻塞
    BPLog(@"方法栈弹出");
}

// 队列组：多层异步
- (void)gcd_deep_group {

    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BPLog(@"1_%@_%d",BPThread);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BPLog(@"2_%@_%d",BPThread);
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...前面的任务不是顺序执行的
        BPLog(@"3_%@_%d",BPThread);
    });
    BPLog(@"方法栈弹出");
}

#pragma mark - 信号量
/*
 
 信号量（semaphore）是PV操作的载体，基本操作有四种：初始化、等信号、给信号、清理
 作用：通过一个计数器实现多线程中的多任务同步，一个线程完成了某一个动作就通过信号量告诉别的线程，别的线程再进行某些动作。

 在使用的时候一定要想清楚哪个需要等待，哪个线程来发送。
 
 过程：
 通常等待信号量和发送信号量的函数是成对出现的。并发执行任务时候，在当前任务执行之前，用dispatch_semaphore_wait函数进行等待（阻塞），直到上一个任务执行完毕后且通过dispatch_semaphore_signal函数发送信号量（使信号量的值加1），dispatch_semaphore_wait函数收到信号量之后判断信号量的值大于等于1，会再对信号量的值减1，然后当前任务可以执行，执行完毕当前任务后，再通过dispatch_semaphore_signal函数发送信号量（使信号量的值加1），通知执行下一个任务......如此一来，通过信号量，就达到了并发队列中的任务同步执行的要求。
 */

- (void)gcd_signal_sync {
    

    /*
     dispatch_semaphore_create：创建信号量，参数value用于初始化semaphore.count。value的有效值不可小于0（否则返回NULL），count>=0是信号量的基本设定，可以定义一个足够大的值。
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    
    // 模仿网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                /*
                 发送信号量，对应信号量的V操作。V操作会将semaphore.count加1，如果存在某个线程因为P操作而阻塞，则该操作会释放其中一个线程。
                 */
                dispatch_semaphore_signal(semaphore);
            });
        });
        NSInteger result = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        BPLog(@"所在的函数出栈");
    });
    /*
     dispatch_semaphore_wait()等待信号量，对应信号量的P操作。P操作尝试将semaphore.count减1，如果semaphore.count大于0，则意味着P操作执行成功，可顺利执行线程之后的逻辑；否则，P操作会阻塞当前线程，直到semaphore.count大于0。
     站在semaphore.count的角度来看，dispatch_semaphore_wait()结果有两种：
     P操作成功，即对semaphore.count成功减1，返回值为0，可顺利执行线程之后的逻辑
     P操作失败，即对semaphore.count没有任何影响，返回值为非0，继续阻塞
     
     达不到条件就阻塞线程，如果达到条件，减1并且不阻塞，以下是条件（信号量的值）：
     如果信号量的值>0 ，减去1并且不阻塞；
     如果信号量的值==0，阻塞当前线程，等待资源被dispatch_semaphore_signal释放，如果等待的期间等到了信号量的值+1了，那么就减1并且不阻塞；如果等待期间信号量的值一直为0（没有等到信号量），那么等到timeout时，其所处线程自动执行其后语句。
     
     timeout表示阻塞的时间长短，有两个常量：DISPATCH_TIME_NOW表示当前，DISPATCH_TIME_FOREVER表示永远。或者自己定义一个时间：
     */
}

- (void)gcd_group_signal {
    // 将多个网络请求任务添加到group中
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestWithUrl:@"A"];
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestWithUrl:@"B"];
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestWithUrl:@"C"];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        BPLog(@"notify_main_%@_%d",BPThread);
    });
}

- (void)requestWithUrl:(NSString *)url {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);//创建信号量：传入的参数必须>=0，否则dispatch_semaphore_create会返回NULL
    /*
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 如果请求成功，发送信号量：计数+1
        dispatch_semaphore_signal(semaphore);
        BPLog(@"signal_%@_%@_%d",url,BPThread);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 如果请求失败，也发送信号量：计数+1
        dispatch_semaphore_signal(semaphore);
        BPLog(@"signal_%@_%@_%d",url,BPThread);
    }];
     */
    
    // 模仿网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(semaphore);//信号量+1
            BPLog(@"完成%@请求任务",url);
        });
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    BPLog(@"%@任务所在的函数出栈",url);
}

// 使用信号量完成请求顺序的依赖
- (void)gcd_signal_dependAction {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [self requestWithSemaphore:semaphore url:@"A"];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self requestWithSemaphore:semaphore url:@"B"];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self requestWithSemaphore:semaphore url:@"C"];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
}

- (void)requestWithSemaphore:(dispatch_semaphore_t)semaphore url:(NSString *)url {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_signal(semaphore);
        BPLog(@"完成%@请求任务",url);
    });
}

- (void)gcd_signal_bug {
    /*
     Bug：当semaphore在被释放时，其值小于原来的初始值，则系统认为该资源仍然处于「in use」状态，对其进行dispose时就会报错…
     如何解决这个问题：使用dispatch_semaphore_create()创建semaphore时，传入0参数，然后使用dispatch_semaphore_signal将semaphore.count加到想要的值
     */
    
    _semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_signal(_semaphore); // 加上这句话，解决bug

    
    /*
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    NSMutableArray *muArray = @[].mutableCopy;

    for (int i = 0; i<100; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [muArray addObject:@(i)];
            BPLog(@"%ld",i);
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
     */
}

#pragma mark - 延长执行
- (void)gcd_after {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testEventWithData:100];
        BPLog(@"gcd_after-延迟执行任务_%@_%d",BPThread);
    });
}

#pragma mark - once
- (void)gcd_once {
    for (int i = 0; i<20; i++) {
        //使用dispatch_once函数能保证某段代码在程序运行过程中只被执行1次
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            BPLog(@"gcd_once-只执行一次_%@_%d",BPThread);
            // 只执行1次的代码，这里默认是线程安全的：不会有其他线程可以访问到这里
        });
    }
}

#pragma mark - 线程通信

- (void)gcd_switchover {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self testEventWithData:100];
        BPLog(@"gcd_switchover-子线程执行任务_%@_%d",BPThread);
        dispatch_async(dispatch_get_main_queue(), ^{
            //回到主线程加载完成刷新
            BPLog(@"gcd_switchover-回到主线程加载完成刷新_%@_%d",BPThread);
        });
    });
}

#pragma mark - apply 遍历
- (void)gcd_apply {
    //异步执行
    dispatch_apply(1000, dispatch_get_global_queue(0, 0), ^(size_t index) {
        BPLog(@"apply- %zd_%@_%d",index,BPThread);
    });
}

#pragma mark - 倒计时
- (void)gcd_initTimer {
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer,DISPATCH_TIME_NOW,1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                BPLog(@"gcd_timer-倒计时结束_%@_%d",BPThread);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置label读秒效果
                BPLog(@"gcd_timer-倒计时ing_%ld_%@_%d",time,BPThread);
            });
            time--;
        }
    });
    dispatch_resume(timer);
}

#pragma mark - 向指定队列里面设置一个标识
- (void)gcd_set_specific {
    
    static void *key = "cactusKey";
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd", NULL);
    
    dispatch_queue_set_specific(queue, key, (void *)[@"cactusValue" UTF8String], NULL);
    
    dispatch_async(queue, ^{
        void *value = dispatch_get_specific(key);
        NSString *str = [[NSString alloc] initWithBytes:value length:7 encoding:4];
        BPLog(@"%@", str);//cactusValue
    });
}

#pragma mark - 指定优先级
- (void)gcd_set_target_queue {
    //优先级变更的串行队列，初始是默认优先级
    dispatch_queue_t serialQueue1 = dispatch_queue_create("com.gcd.setTargetQueue.serialQueue1", NULL);
    
    //优先级不变的串行队列（参照），初始是默认优先级
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.gcd.setTargetQueue.serialQueue2", NULL);
    
    BPLog(@"优先级变更前");
    //变更前
    dispatch_async(serialQueue1, ^{
        BPLog(@"1");
    });
    dispatch_async(serialQueue2, ^{
        BPLog(@"2");
    });
    
    //获取优先级为后台优先级的全局队列
    dispatch_queue_t globalDefaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    //变更优先级： 第一个参数为要设置优先级的queue,第二个参数是参照物，既将第一个queue的优先级和第二个queue的优先级设置一样。
    dispatch_set_target_queue(serialQueue1, globalDefaultQueue);
    
    BPLog(@"优先级变更后");
    //变更后
    dispatch_async(serialQueue1, ^{
        BPLog(@"我优先级低 1");
    });
    dispatch_async(serialQueue2, ^{
        BPLog(@"我优先级高 2");
    });
}

//设置目标队列：队列添加到目标队列。让不同队列中的任务同步的执行时，我们可以创建一个串行队列，然后将这些队列的target指向新创建的队列即可
- (void)gcd_set_target_moreQueue {
    //以下是使用dispatch_set_target_queue将多个串行的queue指定到了同一目标，那么这些串行queue在目标queue上就是同步执行的，不再是并行执行。
    dispatch_queue_t serialQueue1 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue1", NULL);
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue2", NULL);
    dispatch_queue_t serialQueue3 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue3", NULL);
    
//    dispatch_async(serialQueue1, ^{
//        BPLog(@"1");
//    });
//    dispatch_async(serialQueue2, ^{
//        BPLog(@"2");
//    });
//    dispatch_async(serialQueue3, ^{
//        BPLog(@"3");
//    });
    
    //创建目标串行队列
    dispatch_queue_t targetSerialQueue = dispatch_queue_create("com.gcd.setTargetQueue.targetSerialQueue", NULL);
    
    //设置执行阶层：将3个串行队列分别添加到目标队列

    dispatch_set_target_queue(serialQueue1, targetSerialQueue);
    dispatch_set_target_queue(serialQueue2, targetSerialQueue);
    dispatch_set_target_queue(serialQueue3, targetSerialQueue);
    
    dispatch_async(serialQueue1, ^{
        BPLog(@"1");
    });
    dispatch_async(serialQueue2, ^{
        BPLog(@"2");
    });
    dispatch_async(serialQueue3, ^{
        BPLog(@"3");
    });
}

#pragma mark - 死锁：理解执行顺序
- (void)gcd_deadlock {
    
    //http://ios.jobbole.com/82622/
    
    //要理解同步异步函数是否返回这句话，返回其实就是指的';',是否返回跟阻塞其实一回事，直接返回，就不阻塞了，等待返回，就是阻塞；
    
    BPLog(@"1"); // 任务1  //顺序执行：任务1在主线程，主队列中执行；
    dispatch_sync(dispatch_get_main_queue(), ^{
        BPLog(@"2"); // 任务2
    });
    BPLog(@"3"); // 任务3
    //控制台输出：1；
    
    /*先来看看都有哪些任务加入了Main Queue：【任务1，同步函数、任务3】。
     line_38：顺序执行：任务1在主线程，主队列中执行；
     
     line_39：发生死锁：获取主队列，dispatch_sync同步函数将任务2放到主队列里，并阻塞当前线程（在这是主线程）,以及等待任务2返回。
     这时候，同步函数阻塞了主线程，同步函数并等待任务2的返回，但是线程都被阻塞了，block没有线程去执行，进入了互相等待的局面，导致死锁；相当于任务和线程之间有个同步函数裁判在阻隔着。
     
     line_42：不执行
     */
    
    
    BPLog(@"1"); // 任务1
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        BPLog(@"2"); // 任务2
    });
    BPLog(@"3"); // 任务3
    
    //控制台输出：1，2，3；
    
    /*
     line_55：顺序执行：任务1在主线程，主队列中执行；
     
     line_56：顺序执行：获取全局队列，dispatch_sync同步函数将任务2放到全局队列里，并阻塞当前线程（在这是主线程）,以及等待全局队列里的任务2返回。
     这时候，同步函数阻塞了主队列里的主线程，主线程跑到全局队列去执行任务2，同步函数并等待任务2的返回，block块在全局队列里被主线程执行完，返回到主队列；
     
     line_59：顺序执行
     */
    
    
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    BPLog(@"1"); // 任务1
    dispatch_async(queue, ^{
        BPLog(@"2"); // 任务2
        dispatch_sync(queue, ^{
            BPLog(@"3"); // 任务3
        });
        BPLog(@"4"); // 任务4
    });
    BPLog(@"5"); // 任务5
    
    /*控制台输出：
     1，
     5，
     2，
     */
    
    /*
     line_73：顺序执行：创建串行队列；
     
     line_74：顺序执行：任务1在主线程，主队列中执行；
     
     line_75：异步执行：dispatch_async异步函数将block块任务（里面有三个小任务组成一个大任务）放到串行队列里，不会阻塞当前线程（在这是主线程）,不需要等待串行队列里的任务，直接返回。 这时候，串行队列里，一共有三个任务,串行执行,
     
     line_76：顺序执行：任务2在串行队列首先执行；
     
     line_77：死锁：dispatch_sync将任务3放到串行队列里，dispatch_sync任务排在任务3的前面 ，此时并阻塞当前线程：任务2->同步函数->任务4->任务3,发生死锁
     
     line_82：顺序执行
     */
    
    
    BPLog(@"1"); // 任务1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BPLog(@"2"); // 任务2
        dispatch_sync(dispatch_get_main_queue(), ^{
            BPLog(@"3"); // 任务3
        });
        BPLog(@"4"); // 任务4
    });
    BPLog(@"5"); // 任务5
    /*
     以上不会发生死锁
     
     首先，将【任务1、异步线程、任务5】加入Main Queue中，异步线程中的任务是：【任务2、同步线程、任务4】。
     
     所以，先执行任务1，然后将异步线程中的任务加入到Global Queue中，因为异步线程，所以直接返回，任务5执行，结果就是2和5的输出顺序不一定。
     
     然后再看异步线程中的任务执行顺序。任务2执行完以后，遇到同步线程。将同步线程中的任务加入到Main Queue中，这时加入的任务3在任务5的后面。
     
     当任务3执行完以后，没有了阻塞，程序继续执行任务4。
     */
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BPLog(@"1"); // 任务1
        dispatch_sync(dispatch_get_main_queue(), ^{
            BPLog(@"2"); // 任务2
        });
        BPLog(@"3"); // 任务3
    });
    BPLog(@"4"); // 任务4
    while (1) {
    }
    BPLog(@"5"); // 任务5
    
    /*
     
     先来看看都有哪些任务加入了Main Queue：【异步线程、任务4、死循环、任务5】。
     
     在加入到Global Queue异步线程中的任务有：【任务1、同步线程、任务3】。
     
     第一个就是异步函数，直接返回，任务4不用等待直接执行，所以结果任务1和任务4顺序不一定。
     
     任务4完成后，程序进入死循环，Main Queue阻塞。但是加入到Global Queue的异步线程不受影响，继续执行任务1后面的同步线程。
     
     同步线程中，将任务2加入到了主线程，并且，任务3等待任务2完成以后才能执行。这时的主线程，已经被死循环阻塞了。所以任务2无法执行，当然任务3也无法执行，在死循环后的任务5也不会执行。
     
     最终，只能得到1和4顺序不定的结果。
     
     */
}

#pragma mark -  面试题
- (void)change {
    
    for (int i = 0; i<100000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.index = self.index + 1;//不是原子操作,当前线程store的时候可能其他线程已经执行了若干次store了，导致最后的值小于预期值。这种场景我们也可以称之为多线程不安全。
            //self.array = @[@"asd"];
            
        });
    }
}

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
