//
//  BPGCDViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPGCDViewController.h"
#import "AFHTTPSessionManager.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <QuartzCore/QuartzCore.h>

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
                [self gcd_apply];//遍历;
            }
                break;
                
            case 3:{
                [self gcd_initTimer];//倒计时

            }
                break;
                
            case 4:{
                [self gcd_once];//dispatch_once
            }
                break;
                
            case 5:{
                [self gcd_after];//延长执行
            }
                break;
                
            case 6:{
                [self gcd_switchover];//线程通信
            }
                break;
                
                
            case 7:{
                [self gcd_group];//队列组：单层异步
            }
                break;
                
            case 8:{
                [self gcd_deep_group];//队列组：多层异步
            }
                break;
                
            case 9:{
                [self gcd_barrier];//栅栏
            }
                break;
                
            case 10:{
                [self gcd_signal];//使用信号量进行同步操作
            }
                break;
                
            case 11:{
                [self gcd_groupAndSemaphore];//信号量
            }
                break;
                
            case 12:{
                [self gcd_signal_dependAction];//信号量依赖
            }
                break;
                
            case 13:{
                [self gcd_signal_bug];// 信号量源个数导致的bug
            }
                break;
                
            case 14:{
                [self gcd_set_specific];//向指定队列里面设置一个标识
            }
                break;
                
            case 15:{
                [self gcd_set_target_queue];//变更队列优先级
            }
                break;
                
            case 16:{
                [self gcd_set_target_moreQueue];//设置目标队列：队列添加到目标队列
            }
                break;
                
            case 17:{
                [self gcd_signal_lock];
            }
                break;
        }
    }
}

#pragma mark - 队列和同步异步函数
/*
 
 主队列：主队列里只有主线程，不会开辟子线程，串行执行。
 全局队列：4个优先级
 自定义串行队列：串行队列（包括主队列）里至多1个线程；串行执行。
 自定义并发队列：
 
 同步函数：
 1. 阻塞当前队列的线程：不让它在同步函数任务所在的线程在当前队列中执行，并不是说不让线程在其他队列执行;
 2. 需要等待任务返回；
 3. 不会开辟线程；
 
 异步函数：
 1. 不阻塞当前线程;
 2. 不需要等待任务返回；
 3. 可能会开辟线程；
 
 */

- (void)gcd_general {
    // 主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // 全局队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 自定义串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    // 自定义并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue = globalQueue;
    
    // 同步函数
    dispatch_sync(queue, ^{
        [self testEventWithData:0];
        BPLog(@"sync7_%@_%d",BPThread);
    });
    
    // 异步函数
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

#pragma mark - 栅栏

/*
 将异步任务分成两组：当第一组异步任务都执行完成后才执行第二组的异步任务，在两组任务之间形成“栅栏”，使其“下方”的异步任务在其“上方”的异步任务都完成之前是无法执行的。
 
 注意：
 * 栅栏只能跟自定义并行队列一块使用，globalQueue不起作用；
 * 与group的区别，barrier作用是将两个组分开；group的作用是组合成一个组
 * dispatch_barrier_async和dispatch_barrier_sync的区别：是否阻塞的区别；
 
 */

- (void)gcd_barrier {
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("barrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = concurrentQueue;

    dispatch_async(queue, ^{
        [self testEventWithData:10];
        BPLog(@"任务1");
    });

    dispatch_async(queue, ^{
        [self testEventWithData:100];
        BPLog(@"任务2");
    });
    

    BPLog(@"barrieri前");

    dispatch_barrier_sync(queue, ^{ // 同步阻塞
        [self testEventWithData:0];
        BPLog(@"barrieri中");
    });
    
    // 非阻塞
    //    dispatch_barrier_async(queue, ^{
    //        [self testEventWithData:0];
    //        BPLog(@"3_%@_%d",BPThread);
    //    });
    
    BPLog(@"barrier后");

    dispatch_async(queue, ^{
        [self testEventWithData:200];
        BPLog(@"任务3");
    });
    
    dispatch_async(queue, ^{
        [self testEventWithData:50];
        BPLog(@"任务4");
    });
    
    BPLog(@"方法栈弹出");
}

#pragma mark - 线程组：dispatch_group_t

/*
 
 Dispatch Group的本质是一个初始value为LONG_MAX的semaphore，通过信号量来实现一组任务的管理，等待group中的任务完成其实是等待value恢复初始值。
 
 场景：执行多个耗时的异步任务，但是只能等到这些任务都执行完毕后，才能在主线程执行某个任务。
 
 */

// 队列组：单层异步
- (void)gcd_group {

    // 创建一个信号量
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        [self testEventWithData:2000];
        BPLog(@"任务1");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self testEventWithData:10];
        BPLog(@"任务2");
    });
    
    // 非阻塞
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...
        BPLog(@"notify");
    });
    
    BPLog(@"wait");
    
    // 阻塞，如果超过了指定时间或者是在指定时间内完成了任务，可以继续往下执行，否则就长久阻塞
    // dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
    BPLog(@"方法栈弹出");
}

// 队列组：多层异步
- (void)gcd_deep_group {

    // 创建一个信号量
    dispatch_group_t group = dispatch_group_create();
    
    // 信号量的计数减去1；
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BPLog(@"任务1");
        // 信号量的计数加上1；
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BPLog(@"任务2");
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...前面的任务不是顺序执行的
        BPLog(@"notify");
    });
    BPLog(@"方法栈弹出");
}

#pragma mark - 信号量：dispatch_semaphore_t
/*
 
 通过一个计数器实现并发队列中的任务同步，一个线程完成了某一个动作，通过发送（释放）信号量告诉其他线程，其他线程再进行某些动作。在使用的时候一定要想清楚哪个需要等待，哪个线程来发送。
 
 信号量用来实现并发队列中的任务，同步执行；保证线程安全

 注意：
 * 通常等待信号量和发送信号量的函数是成对出现；
 * dispatch_semaphore_t：创建信号量，参数必须大于等于0
 * dispatch_semaphore_signal：发送（释放）信号量（使信号量的值加1）
 * dispatch_semaphore_wait：等待信号量（如果<= 0就一直等待），如果信号量的值>0，向下执行，信号量-1（内部原子性操作）；否则阻塞，等待信号量被释放；如果等待期间信号量一直为0，并且超时，其所处线程自动执行其后语句；
 
 */

- (void)gcd_signal {
    
    // 创建信号量：必须大于等于0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    // 模仿网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 释放（发送）信号量：使信号量+1
            NSInteger result = dispatch_semaphore_signal(semaphore);
            BPLog(@"signal %d",result);
        });
    });
    
    // 等待信号量（如果<= 0就一直等待）：
    // 如果>0，向下执行，信号量-1（内部原子性操作）,否则阻塞,等待信号量被释放，如果等待期间信号量一直为0，并且超时，其所处线程自动执行其后语句
    // timeout表示阻塞的时间长短，有两个常量：DISPATCH_TIME_NOW表示当前，DISPATCH_TIME_FOREVER表示永远。或者自己定义一个时间：

    NSInteger result = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    BPLog(@"wait %d",result);
    BPLog(@"所在的函数出栈");
}

// 当作锁使用
- (void)gcd_signal_lock {
    
    __block int number = 0;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);

    for (int i = 0; i < 10000; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            number++;
            dispatch_semaphore_signal(semaphore);
        });
    }
}

// 使用线程组和信号量完成批量请求，全部的响应返回之后，统一处理

- (void)gcd_groupAndSemaphore {
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

// 模仿网络请求
- (void)requestWithUrl:(NSString *)url {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(semaphore);
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

// dealloc的时候 必须恢复信号量的初始值
// 当semaphore在被释放时，其值小于原来的初始值，则系统认为该资源仍然处于「in use」状态，对其进行dispose时就会报错。
// 解决：使用dispatch_semaphore_signal将semaphore.count加到想要的值
- (void)gcd_signal_bug {
    _semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    // 加上这句话，解决bug
    dispatch_semaphore_signal(_semaphore);
}

#pragma mark - 延迟执行
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
    dispatch_apply(1000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
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
        //倒计时结束，关闭
        if(time <= 0){
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                BPLog(@"gcd_timer-倒计时结束_%@_%d",BPThread);
            });
        }else {
            //设置label读秒效果
            dispatch_async(dispatch_get_main_queue(), ^{
                BPLog(@"gcd_timer-倒计时ing_%ld_%@_%d",time,BPThread);
            });
            time--;
        }
    });
    dispatch_resume(timer);
}

#pragma mark - 设置指定队列标识
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

#pragma mark - 变更优先级
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

#pragma mark - 设置目标队列：将多个队列分别添加到目标队列

- (void)gcd_set_target_moreQueue {
    
    dispatch_queue_t serialQueue1 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue1", NULL);
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue2", NULL);
    dispatch_queue_t serialQueue3 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue3", NULL);
    
    //创建目标串行队列
    dispatch_queue_t targetSerialQueue = dispatch_queue_create("com.gcd.setTargetQueue.targetSerialQueue", NULL);
    
    //将3个串行队列分别添加到目标队列，这些串行queue在目标queue上就是同步执行的，不再是并行执行。
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

#pragma mark - 取消任务
- (void)gcd_cancel {
    [self gcd_block_cancel];
    [self gcd_extern_var];//通过定义外部变量，判断是否进行，否就return
    [self gcd_block_suspend];
}

/*
 1.必须用dispatch_block_create创建dispatch_block_t任务
 2.dispatch_block_cancel也只能取消尚未执行的任务，对正在执行的任务不起作用。也就是说此方法具有不确定性
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

//dispatch_suspend 挂起当前队列，并不是取消；也不会立即暂停正在运行的block，而是在当前block执行完成后，暂停后续的block执行。
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
}

@end
