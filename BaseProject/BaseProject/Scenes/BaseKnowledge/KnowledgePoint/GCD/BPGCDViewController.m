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


@interface BPGCDViewController ()

@end

@implementation BPGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self gcd_general];
//    [self gcd_cancel];
//    [self gcd_deadlock];

//    [self gcd_applications];
//    [self gcd_safe];
//    [self gcd_test];
}

- (void)gcd_test {
    /*
    任何需要刷新 UI 的工作都要由主线程执行，所以一般耗时的任务都要开辟子线程，让子线程来执行。主队列里只有主线程。UI刷新放在主线程里进行这种说法是不对的，因为线程是执行者，而队列是存放任务的，UI刷新是任务，应该说UI刷新必须由主线程进行,但是UI刷新不一定存放在主队列里，比如可以存放在同步自定义串行队列。
    
    串行与并行针对的是队列，而同步与异步，针对的则是线程。最大的区别在于，同步线程要阻塞当前线程，必须要等待同步线程中的任务执行完，返回以后，才能继续执行下一任务；而异步线程则是不用等待。
     
     添加任务和任务执行时间不一样；
     一开始就确认了任务的顺序；
     

    */
    
    
    //自定义串行串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd", DISPATCH_QUEUE_SERIAL);

    //异步任务1加入串行队列中
    dispatch_async(queue, ^{
        BPLog(@"串行队列任务1");
        for (NSInteger i = 0; i < 10; i++) {
            BPLog(@"串行队列任务1_i:%ld",i);
        }
    });
    //同步任务2加入串行队列中
    dispatch_sync(queue, ^{
        BPLog(@"串行队列任务2");
        for (NSInteger i = 0; i < 10; i++) {
            BPLog(@"串行队列任务2_i:%ld",i);
        }

    });

    //1.
    dispatch_async(dispatch_get_main_queue(), ^{
        BPLog(@"2");
    });
    BPLog(@"1");
    BPLog(@"3");
    BPLog(@"4");
    BPLog(@"5");
    BPLog(@"6");
    //执行顺序 1 -> 3 -> ... -> 6 -> 2
    //???:什么时机将BPLog(@"2");添加到主队列去的

    
    //2.
    dispatch_async(dispatch_get_main_queue(), ^{
        BPLog(@"1");
    });

    dispatch_async(dispatch_get_main_queue(), ^{
        BPLog(@"2");
    });
    //执行顺序 1 -> 2
}

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


#pragma mark - 一般使用：同步异步函数；串行并行队列
/*
 
 任务是最小的基本单元，可以是末尾带;的一句话。任务都是放到队列里的队列则是用于保存以及管理任务的；线程是执行任务的。
 
 队列：存放任务并确定队列里面的任务是怎么执行的，是串行还是并行；
 任务：block块；同步任务；异步任务；
 同步异步函数：将同步异步函数放到当前队列里->当前的线程去执行当前对列里的同步异步函数->同步异步函数（是否）阻塞当前线程->同步异步函数将任务放到队列中->是否等待任务返回；
 同步（sync）：将任务放到队列中->阻塞当前线程->等待任务返回;只能在当前线程中执行任务,也就是说没有开辟线程的能力；
 异步（async）：将任务放到队列中->不阻塞当前线程->不需要等待任务直接返回;有开辟线程的能力；
 执行结束：线程释放；
 
 要注意在多线程环境下的安全：一般指的是写操作，读操作不需要；
 
    通道（串行队列）  通道（并行队列）
        |  |       |         |
        |  |       |         |
        |  |       |         |
        |  |       |         |
        |O |       |O O O O O|
 
  线程去执行任务.................
 
 在主队列主线程的环境下：
 
 同步主队列：：将同步函数放到主队列里，同步函数阻塞主线程，同步函数将任务添加到主队列里，同步函数并等待任务执行结果，因为是主队列，所以主队列里只有主线程，发生死锁;
 同步全局队列：将同步函数放到主队列里，同步函数阻塞主线程，同步函数将任务添加到全局队列里，同步函数并等待任务执行结果，主线程去全局队列执行任务，任务完成，返回;（虽然是全局队列，但是同步函数会一个任务一个任务的执行，相当于串行执行）
 同步自定义串行对列：将同步函数放到主队列里，同步函数阻塞主线程，同步函数将任务添加到自定义串行队列里，同步函数并等待任务执行结果，主线程去自定义串行执行任务，任务完成，返回;
 同步自定义并行队列：将同步函数放到主队列里，同步函数阻塞主线程，同步函数将任务添加到自定义并行队列，同步函数并等待任务执行结果，主线程去自定义并行队列里执行任务，任务完成，返回;（虽然是自定义并行队列，但是同步函数会一个任务一个任务的执行，相当于串行执行）
 
 异步主队列：将异步函数放到主队列里，异步函数不会阻塞主线程，异步函数将任务添加到主队列里，立即返回，因为是主队列，所以只有主线程（不会开辟子线程），所以主线程去全局队列执行任务，任务完成;（串行执行）
 异步全局队列：将异步函数放到主队列里，异步函数不会阻塞主线程，异步函数将任务添加到全局队列里，立即返回，因为是全局队列，所以会并行执行, 所以会开辟一个或者多个子线程，执行任务，任务完成;
 异步自定义串行队列：将异步函数放到主队列里，异步函数不会阻塞主线程，异步函数将任务添加到自定义串行队列里，立即返回，因为是自定义串行队列，默认开始此队列没有线程，所以会开辟子线程，但是又因为是串行队列，即使开辟多个子线程也会串行执行，所以不会开辟多个线程浪费资源，只会开辟一个子线程，执行任务，任务完成;（串行执行）
 异步自定义并发队列：将异步函数放到主队列里，异步函数不会阻塞主线程，异步函数将任务添加到自定义并发队列里，立即返回，因为是自定义并发队列，所以会并行执行, 所以会开辟一个或者多个子线程，执行任务，任务完成;
 
 注意：串行队列里至多1个线程，可以是主线程，也可以是子线程，但是只有一个。
 
 思考：
 在自定义串行队列+主线程的环境下；
 在自定义串行队列+子线程的环境下；

 主队列的特殊性：所有放在主队列中的任务都会在主线程上执行，
 据此可得，主队列中，即使有异步任务，也会依次在主线程上执行，一般在回到主线程的例子中：任务放到主队列的后面，因为主队列是串行队列，等主线程上的前面的代码执行完，所以异步函数里的任务会等主线程上的任务执行完再执行。
 
 */
- (void)gcd_general {
    /*

     串行队列：任务按顺序执行
     并行队列：不按顺序
     
     */
    
    //[self customQueue];
    
    [self systemQueue];
}

#pragma mark - 创建队列
- (void)customQueue {
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    /*
     1. 同步自定义串行队列：同步非阻塞;
     2. 同步自定义并行队列：同步非阻塞;
     
     同步：
     1. 阻塞当前队列的线程：不让他在同步函数任务所在的线程在当前队列中执行，并不是说也不让线程在其他队列执行;
     2. 需要等待任务返回；
     3. 不会开辟线程；
     */
    [self testSync:serialQueue];
    
    /*
     1. 异步自定义串行队列：异步开辟线程;// 确实会开辟但是我觉得没意义啊
     2. 异步自定义并行队列：异步开辟线程;
     
     异步：
     1. 不阻塞当前线程;
     2. 不需要等待任务返回；
     3. 可能会开辟线程；
     */
    //    [self testAsync:concurrentQueue];
}

#pragma mark - 获取系统队列
- (void)systemQueue {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    /*
     1. 同步主队列：死锁;
     2. 同步全局队列：同步非阻塞;
     
     同步：
     1. 阻塞当前队列的线程：不让他在同步函数任务所在的线程在当前队列中执行，并不是说也不让线程在其他队列执行;
     2. 需要等待任务返回；
     3. 不会开辟线程；
     */
    
    //    [self testSync:globalQueue];
    
    /*
     1. 异步主队列：不开辟线程;
     2. 异步全局队列：异步开辟线程;
     
     异步：
     1. 不阻塞当前线程;
     2. 不需要等待任务返回；
     3. 可能会开辟线程；
     */
        [self testAsync:mainQueue];
}

- (void)testSync:(dispatch_queue_t)queue {
    dispatch_sync(queue, ^{
        [self testEventWithData:120];
        BPLog(@"sync1_%@_%d",BPThread);
    });
    
    dispatch_sync(queue, ^{
        [self testEventWithData:100];
        BPLog(@"sync2_%@_%d",BPThread);
    });
    
    dispatch_sync(queue, ^{
        [self testEventWithData:90];
        BPLog(@"sync3_%@_%d",BPThread);
    });
    
    dispatch_sync(queue, ^{
        [self testEventWithData:80];
        BPLog(@"sync4_%@_%d",BPThread);
    });
    
    dispatch_sync(queue, ^{
        [self testEventWithData:70];
        BPLog(@"sync5_%@_%d",BPThread);
    });
    
    dispatch_sync(queue, ^{
        [self testEventWithData:60];
        BPLog(@"sync6_%@_%d",BPThread);
    });
    
    dispatch_sync(queue, ^{
        [self testEventWithData:0];
        BPLog(@"sync7_%@_%d",BPThread);
    });
}

#pragma mark - 取消任务
- (void)gcd_cancel {
//    [self gcd_block_cancel];
//    [self gcd_extern_var];//通过定义外部变量，判断是否进行，否就return
//    [self gcd_block_suspend];
//    [self gcd_block_testcancel];
    
//     NSOperation，NSOperation天生支持Cancel，调用其cancel方法即可
}


//测试给定的分派块是否被取消。
- (void)gcd_block_testcancel {
    dispatch_queue_t queue = dispatch_queue_create("com.gcdtest.www", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        sleep(5);
        BPLog(@"1-gcd_block_testcancel-block1 %@_%d",BPThread);
        [self testEventWithData:1000];
    });

    NSInteger result =  dispatch_block_testcancel(block1);//测试给定的分派块是否被取消。
    BPLog(@"3-gcd_block_testcancel-block1 %@_%d_%ld",BPThread,result);
    if (result>0) {
        BPLog(@"取消成功");
    }else {
        BPLog(@"取消失败");
    }

    dispatch_async(queue, block1);
    BPLog(@"2-gcd_block_testcancel-block1_%@_%d",BPThread);
    
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        sleep(5);
        BPLog(@"4-block2_%@_%d",BPThread);
    });
    BPLog(@"5-block2_%@_%d",BPThread);
    dispatch_async(queue, block2);
    BPLog(@"6-block2_%@_%d",BPThread);
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

/*
 
 1.iOS8后的api
 2.必须用dispatch_block_create创建dispatch_block_t任务
 3.dispatch_block_cancel也只能取消尚未执行的任务，对正在执行的任务不起作用。

 */

- (void)gcd_block_cancel{
    dispatch_queue_t queue = dispatch_queue_create("com.gcdtest.www", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        sleep(5);
        BPLog(@"block1 %@",[NSThread currentThread]);
    });
    
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        BPLog(@"block2 %@",[NSThread currentThread]);
    });
    
    dispatch_block_t block3 = dispatch_block_create(0, ^{
        BPLog(@"block3 %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, block1);
    dispatch_async(queue, block2);
    dispatch_block_cancel(block3);
}

- (void)gcd_extern_var{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __block BOOL isCancel = NO;
    
    dispatch_async(queue, ^{
        BPLog(@"任务001 %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        BPLog(@"任务002 %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        BPLog(@"任务003 %@",[NSThread currentThread]);
        isCancel = YES;
    });
    
    dispatch_async(queue, ^{
        // 模拟：线程等待3秒，确保任务003完成 isCancel＝YES
        sleep(3);
        if(isCancel){
            BPLog(@"任务004已被取消 %@",[NSThread currentThread]);
        }else{
            BPLog(@"任务004 %@",[NSThread currentThread]);
        }
    });
}

#pragma mark - 具体应用: 倒计时；延长执行；依赖-信号量;遍历;线程通信
- (void)gcd_applications {
//    [self gcd_apply];//遍历;
//    [self gcd_initTimer];//倒计时
//    [self gcd_switchover];//线程通信
//    [self gcd_after];//延长执行
//    [self gcd_once];//dispatch_once
//    [self gcd_group];//队列组
    [self gcd_barrier];//栅栏
//    [self gcd_signal_one];//信号量
//    [self gcd_signal_two];//信号量
//    [self gcd_signal_three_dependAction];//信号量依赖
}

- (void)gcd_barrier {
    /*
     需求点：虽然我们有时要执行几个不同的异步任务，但是我们还是要将其分成两组：当第一组异步任务都执行完成后才执行第二组的异步任务。这里的组可以包含一个任务，也可以包含多个任务。
     在两组任务之间形成“栅栏”，使其“下方”的异步任务在其“上方”的异步任务都完成之前是无法执行的。
     */
    dispatch_queue_t queue = dispatch_queue_create("barrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        BPLog(@"gcd_barrier-1_1-_%@_%d",BPThread);
        [self testEventWithData:300];
        BPLog(@"gcd_barrier-1_2-_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        BPLog(@"gcd_barrier-2_1-_%@_%d",BPThread);
        [self testEventWithData:100];
        BPLog(@"gcd_barrier-2_2-_%@_%d",BPThread);
    });
    
    dispatch_barrier_async(queue, ^{
        BPLog(@"gcd_barrier-3_1-_%@_%d",BPThread);
        [self testEventWithData:0];
        BPLog(@"gcd_barrier-3_2-_%@_%d",BPThread);
    });
    
    dispatch_async(queue, ^{
        BPLog(@"gcd_barrier-4_1-_%@_%d",BPThread);
        [self testEventWithData:200];
        BPLog(@"gcd_barrier-4_2-_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        BPLog(@"gcd_barrier-5_1-_%@_%d",BPThread);
        [self testEventWithData:50];
        BPLog(@"gcd_barrier-5_2-_%@_%d",BPThread);
    });
}

/*
 
 信号量用在多线程多任务同步的，一个线程完成了某一个动作就通过信号量告诉别的线程，别的线程再进行某些动作。
 在多线程环境下用来确保代码不会被并发调用。在进入一段代码前，必须获得一个信号量，在结束代码前，必须释放该信号量，想要执行该代码的其他线程必须等待直到前者释放了该信号量。
 
 信号量通过一个计数器控制对共享资源的访问，信号量的值是一个非负整数，所有通过它的线程都会将该整数减一。如果计数器大于0，则访问被允许，计数器减1；如果为0，则访问被禁止，所有试图通过它的线程都将处于等待状态。
 计数器计算的结果是允许访问共享资源的通行证。因此，为了访问共享资源，线程必须从信号量得到通行证， 如果该信号量的计数大于0，则此线程获得一个通行证，这将导致信号量的计数递减，否则，此线程将阻塞直到获得一个通行证为止。当此线程不再需要访问共享资源时，它释放该通行证，这导致信号量的计数递增，如果另一个线程等待通行证，则那个线程将在那时获得通行证。
 
 1.在自线程队列中 。设置的信号等待 ，一直到block回调完成（主线程中），发送信号 。子线程收到信号，然后才会通知dispatch_group_notify 子线程的请求数据真正返回了。
 2.在使用的时候一定要想清楚哪个需要等待，哪个线程来发送。
 
 */
- (void)gcd_signal_one {
    NSString *appIdKey = @"8781e4ef1c73ff20a180d3d7a42a8c04";
    NSString* urlString_1 = @"http://api.openweathermap.org/data/2.5/weather";
    NSString* urlString_2 = @"http://api.openweathermap.org/data/2.5/forecast/daily";
    NSDictionary* dictionary =@{@"lat":@"40.04991291",
                                @"lon":@"116.25626162",
                                @"APPID" : appIdKey};
    
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    // 将第一个网络请求任务添加到组中
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //创建信号量：值得注意的是，这里的传入的参数value必须大于或等于0，否则dispatch_semaphore_create会返回NULL。如果为 0 并随后调用 wait 方法，线程将被阻塞直到别的线程调用了 signal 方法。
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString_1
          parameters:dictionary
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 BPLog(@"gcd_signal-one-1_2_%@_%d",BPThread);
                 //发送信号量：计数+1
                 //这个函数会使传入的信号量dsema的值加1；（至于返回值，待会儿再讲）
                 
                 dispatch_semaphore_signal(semaphore);
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 BPLog(@"gcd_signal-one-1_3_%@_%d",BPThread);
                 //发送信号量：计数+1
                 dispatch_semaphore_signal(semaphore);
             }];
        BPLog(@"gcd_signal-one-1_1_%@_%d",BPThread);
        /*
        这个函数的作用是这样的，如果dsema信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1；
        　　如果desema的值为0，那么这个函数就阻塞当前线程等待timeout（注意timeout的类型为dispatch_time_t，
        　　不能直接传入整形或float型数），如果等待的期间desema的值被dispatch_semaphore_signal函数加1了，
        　　且该函数（即dispatch_semaphore_wait）所处线程获得了信号量，那么就继续向下执行并将信号量减1。
        　　如果等待期间没有获取到信号量或者信号量的值一直为0，那么等到timeout时，其所处线程自动执行其后语句。
         
         // 在网络请求任务成功之前，信号量等待中：设置等待时间，这里设置的等待时间是一直等待。

         */
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//告知当前线程不要立即告诉dispatch_group_notify，要等block释放完给你发通知释放，才能去dispatch_group_notify；
    });
    
    // 将第二个网络请求任务添加到组中
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建信号量：如果semaphore计数大于等于1，计数-1，返回，程序继续运行。如果计数为0，则等待。
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString_2
          parameters:dictionary
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 BPLog(@"gcd_signal-one-2_2_%@_%d",BPThread);
                 // 如果请求成功，发送信号量：计数+1
                 dispatch_semaphore_signal(semaphore);
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 BPLog(@"gcd_signal-one-2_3_%@_%d",BPThread);
                 // 如果请求失败，也发送信号量：计数+1
                 dispatch_semaphore_signal(semaphore);
             }];
        // 在网络请求任务成功之前，信号量等待中：设置等待时间，这里设置的等待时间是一直等待。
        BPLog(@"gcd_signal-one-2_1_%@_%d",BPThread);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BPLog(@"gcd_signal-one-3_%@_%d",BPThread);
    });
}

- (void)gcd_signal_two {
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
        //刷新界面
        BPLog(@"gcd_signal-two_notify_main_%@_%d",BPThread);
    });
    
    //还有一种情况就是，如果最后一个网络请求是依赖前面的所有请求.这里需要这样改一下
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //刷新界面
        BPLog(@"gcd_signal-two_notify_global_%@_%d",BPThread);
    });
}

- (void)requestWithUrl:(NSString *)url {
    BPLog(@"gcd_signal-two_begin_%@_%@_%d",url,BPThread);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             BPLog(@"gcd_signal-two_result_%@_%@_%d",url,BPThread);
             // 如果请求成功，发送信号量：计数+1
             dispatch_semaphore_signal(semaphore);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             BPLog(@"gcd_signal-two_result_%@_%@_%d",url,BPThread);
             // 如果请求失败，也发送信号量：计数+1
             dispatch_semaphore_signal(semaphore);
         }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}


- (void)gcd_signal_three_dependAction {
    //异步执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [self request];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self request];
    });
}

- (void)request {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)gcd_group {
    /*
     需求点：执行多个耗时的异步任务，但是只能等到这些任务都执行完毕后，才能在主线程执行某个任务。为了实现这个需求，我们需要让将这些异步执行的操作放在dispatch_group_async函数中执行，最后再调用dispatch_group_notify来执行最后执行的任务。
     首先：分别异步执行2个耗时的操作
     其次：等2个异步操作都执行完毕后，再回到主线程执行操作
     如果想要快速高效地实现上述需求，可以考虑用队列组;
     
     但是有缺陷！！！ 如果你在线程里使用了block，并且需要在block里返回的时机，group可能就不适合了，这时候需要信号量
     
     */
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        BPLog(@"gcd_group-1_1-延迟执行任务_%@_%d",BPThread);
        [self testEventWithData:200];
        BPLog(@"gcd_group-1_2-延迟执行任务_%@_%d",BPThread);
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BPLog(@"gcd_group-2_1-延迟执行任务_%@_%d",BPThread);
        [self testEventWithData:100];
        BPLog(@"gcd_group-2_2-延迟执行任务_%@_%d",BPThread);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...
        BPLog(@"gcd_group_notify-2_2-延迟执行任务_%@_%d",BPThread);
    });
}

- (void)gcd_after {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testEventWithData:100];
        BPLog(@"gcd_after-延迟执行任务_%@_%d",BPThread);
    });
}

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

- (void)gcd_apply {
    //异步执行
    dispatch_apply(1000, dispatch_get_global_queue(0, 0), ^(size_t index) {
        BPLog(@"apply- %zd_%@_%d",index,BPThread);
    });
}

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

- (void)testAsync:(dispatch_queue_t)queue {
    
    //    dispatch_async(queue, ^{
    //        BPLog(@"async1_%@_%d",BPThread);
    //        BPLog(@"async2_%@_%d",BPThread);
    //
    //        BPLog(@"async3_%@_%d",BPThread);
    //        BPLog(@"async4_%@_%d",BPThread);
    //        BPLog(@"async5_%@_%d",BPThread);
    //        BPLog(@"async6_%@_%d",BPThread);
    //        BPLog(@"async7_%@_%d",BPThread);
    //
    //        BPLog(@"async8_%@_%d",BPThread);
    //
    //    });
    dispatch_async(queue, ^{
        [self testEventWithData:200];
        BPLog(@"async1_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        [self testEventWithData:150];

        BPLog(@"async2_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        [self testEventWithData:120];
        BPLog(@"async3_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        [self testEventWithData:100];
        BPLog(@"async4_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        [self testEventWithData:90];
        BPLog(@"async5_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        [self testEventWithData:80];
        BPLog(@"async6_%@_%d",BPThread);
    });
    dispatch_async(queue, ^{
        [self testEventWithData:0];
        BPLog(@"async7_%@_%d",BPThread);
    });
}

- (void)testEventWithData:(NSInteger)limit {
    for (int i = 0; i<limit; i++) {
        NSNumber *number = @(i);
        BPLog(@"%d",i);
    }
}

#pragma mark - 多线程的安全——原子性、原子操作，锁，信号量
/*
 <1> 多线程安全：
 多线程任务执行同一块代码->同步策略执行：原子操作 或者 加锁 或者 使用信号量进行同步操作
 一般在单线程环境下，不需要考虑安全的问题，但是在多线程的环境下，多个线程同时修改同一资源有可能以意想不到的方式互相干扰。这时候需要多线程安全的知识了，一般的操作原理就是通过加锁或者使用信号量的方法让线程同步执行：保证一段代码段在同一个时间只能允许被一个线程访问。
 
 常用的同步策略有线程锁、信号量、原子操作。线程锁较为简单粗暴，简单的说当一个线程在操作变量时会挂上一把互斥锁，如果另一个线程先要操作该变量，它就得获得这把锁，但是锁只有一个，必须等第一个线程释放互斥锁后，才可以被其他线程获取，所以这样就解决了资源竞争的问题。信号量策略是通过线程或任务的执行情况生成一个状态，这个状态即像门卫又像协管员，一是阻止线程进行，二是以合适的执行顺序安排协调各个任务。第三个策略则是原子操作，相对前两个策略要更轻量级一些，它能通过硬件指令保证变量在更新完成之后才能被其他线程访问。
 

 
 临界区：简而言之就是两个或多个线程不能同时执行一段代码去操作一个共享的资源。这些代码段在同一个时间只能允许被一个线程访问

 
 <2> 原子性及原子操作：
 原子操作是指不会被线程调度机制打断的操作；这种操作一旦开始，就一直运行到结束，中间不会有任何换到另一个线程.
 原子操作是不可分割的，在执行完毕之前不会被任何其它任务或事件中断。
 原子操作是最简单也是最基本的保证线程安全的方法，原子的本意是不能被分裂的最小粒子，故原子操作是不可被中断的一个或一系列操作。从处理器角度来说原子操作是当一个处理器读取一个字节时，其他处理器不能访问这个字节的内存地址，从应用层面来说就是当一个线程对共享变量进行操作时，其他线程不能对该变量进行操作，并且其他线程不会被阻塞。
 
 <3>  线程同步任务或者线程同步函数：
 阻塞当前线程，等待任务的返回 ：多条线程在同一条线上执行（按顺序地执行任务）
 
 <4> 互斥条件：
 指进程对所分配到的资源进行排它性使用，即在一段时间内某资源只由一个进程占用。如果此时还有其它进程请求资源，则请求者只能等待，直至占有资源的进程用毕释放。
 
 <5> 忙等：
 线程不会休眠，一直死循环
 
 <6> 信号量:
 在多线程环境下用来确保代码不会被并发调用。在进入一段代码前，必须获得一个信号量，在结束代码前，必须释放该信号量，想要执行该代码的其他线程必须等待直到前者释放了该信号量。
 信号量通过一个计数器控制对共享资源的访问，信号量的值是一个非负整数，所有通过它的线程都会将该整数减一。如果计数器大于0，则访问被允许，计数器减1；如果为0，则访问被禁止，所有试图通过它的线程都将处于等待状态。
 计数器计算的结果是允许访问共享资源的通行证。因此，为了访问共享资源，线程必须从信号量得到通行证， 如果该信号量的计数大于0，则此线程获得一个通行证，这将导致信号量的计数递减，否则，此线程将阻塞直到获得一个通行证为止。当此线程不再需要访问共享资源时，它释放该通行证，这导致信号量的计数递增，如果另一个线程等待通行证，则那个线程将在那时获得通行证。
 
 <7> 锁、线程锁、临界区：
 锁可以保护临界区，代码在临界区同一时间只会被一个线程执行。有互斥锁、递归锁、读写锁、分布锁、自旋锁、双重检查锁等等。
 锁是最常用的同步工具：：申请开锁->加锁->释放锁。一段代码段在同一个时间只能允许被一个线程访问，比如一个线程A进入加锁代码之后由于已经加锁，另一个线程B就无法访问，只有等待前一个线程A执行完加锁代码后解锁，B线程才能访问加锁代码。
 
 锁的类别
 自旋锁，互斥锁，递归锁，条件锁等
 
 锁-自旋锁
 OC在定义属性的时候有atomic和nonatomic两种方式
 atomic：原子属性，线程安全，需要消耗大量的资源，只会给setter方法加锁，不会给getter方法加锁。本质上是用的NSLock。atomic的本意是指属性的存取方法是线程安全的（thread safe），并不保证整个对象是线程安全的。比如，声明一个NSMutableArray的原子属性mutarr，此时self.muArray和self.muArray = othermutarr都是线程安全的。但是，使用[self.muArray addobject:obj]就不是线程安全的，需要用锁来保证线程安全性。
 nonatomic：非原子属性，非线程安全，不会给setter方法加锁，在像iPhone这种内存较小的移动设备上，如果没有多线程间的通信，那么nonatomic就是一个非常好的选择。
 一般情况下，我们都只需要在主线程中进行操作的，所以是不需要加锁的。
 
 锁-互斥锁
 就是使用了线程同步技术，一种用来防止多个线程同一时刻对共享资源进行访问的信号量，它的原子性确保了如果一个线程锁定了一个互斥，将没有其他线程在同一时间可以锁定这个互斥。它的唯一性确保了只有它解锁了这个互斥，其他线程才可以对其进行锁定。当一个线程锁定一个资源的时候，其他对该资源进行访问的线程将会被挂起，直到该线程解锁了互斥，其他线程才会被唤醒，进一步才能锁定该资源进行操作。
 互斥锁在申请锁时，调用了pthread_mutex_lock 方法，它在不同的系统上实现各有不同，有时候它的内部是使用信号量来实现，即使不用信号量，也会调用到 lll_futex_wait 函数，从而导致线程休眠。
 
 自旋锁和互斥锁的区别：
 如果是互斥锁, 假如现在被锁住了, 那么后面来得线程就会进入”休眠”状态, 直到解锁之后, 又会唤醒线程继续执行
 如果是自旋锁, 假如现在被锁住了, 那么后面来得线程不会进入休眠状态, 在进程中空转，就是执行一个空的循环(一直在消耗性能), 直到解锁之后立刻执行
 自旋锁更适合做一些较短的操作；
 自旋锁的效率高于互斥锁；
 
 <8> 死锁：
 死锁是指两个或两个以上的进程（线程）在执行过程中，由于竞争资源或者由于彼此通信而造成的一种阻塞的现象，若无外力作用，它们都将无法推进下去。
 一般情况下，一个线程只能申请一次锁，也只能在获得锁的情况下才能释放锁，多次申请锁或释放未获得的锁都会导致崩溃。假设在已经获得锁的情况下再次申请锁，线程会因为等待锁的释放而进入睡眠状态，因此就不可能再释放锁，从而导致死锁。
 然而这种情况经常会发生，比如某个函数申请了锁，在临界区内又递归调用了自己。辛运的是pthread_mutex支持递归锁，也就是允许一个线程递归的申请锁，只要把 attr 的类型改成 PTHREAD_MUTEX_RECURSIVE 即可。
 
 执行这个dispatch_get_main_queue队列的是主线程。执行了dispatch_sync函数后，将block添加到了main_queue中，同时调用dispatch_syn这个函数的线程（也就是主线程）被阻塞，等待block执行完成，而执行主线程队列任务的线程正是主线程，此时他处于阻塞状态，所以block永远不会被执行，因此主线程一直处于阻塞状态。因此这段代码运行后，并非卡在block中无法返回，而是根本无法执行到这个block。
 
 <9> 信号量与互斥锁之间的区别：
 
 1. 互斥用于线程的互斥，信号线用于线程的同步。
 
 这是互斥和信号量的根本区别，也就是互斥和同步之间的区别。
 
 互斥：是指某一资源同时只允许一个访问者对其进行访问，具有唯一性和排它性。但互斥无法限制访问者对资源的访问顺序，即访问是无序的。
 
 同步：是指在互斥的基础上（大多数情况），通过其它机制实现访问者对资源的有序访问。在大多数情况下，同步已经实现了互斥，特别是所有写入资源的情况必定是互斥的。少数情况是指可以允许多个访问者同时访问资源
 
 2. 互斥值只能为0/1，信号量值可以为非负整数。
 
 也就是说，一个互斥只能用于一个资源的互斥访问，它不能实现多个资源的多线程互斥问题。信号量可以实现多个同类资源的多线程互斥和同步。当信号量为单值信号量是，也可以完成一个资源的互斥访问。
 
 3. 互斥的加锁和解锁必须由同一线程分别对应使用，信号量可以由一个线程释放，另一个线程得到。
 
 区别总结：
 信号量用在多线程多任务同步的，一个线程完成了某一个动作就通过信号量告诉别的线程，别的线程再进行某些动作。而互斥锁是用在多线程多任务互斥的，一个线程占用了某一个资源，那么别的线程就无法访问，直到这个线程unlock，其他的线程才开始可以利用这个资源。比如对全局变量的访问，有时要加锁，操作完了，再解锁。有的时候锁和信号量会同时使用的。
 也就是说，信号量不一定是锁定某一个资源，而是流程上的概念，比如：有A,B两个线程，B线程要等A线程完成某一任务以后再进行自己下面的步骤，这个任务 并不一定是锁定某一资源，还可以是进行一些计算或者数据处理之类。而线程互斥量则是“锁住某一资源”的概念，在锁定期间内，其他线程无法对被保护的数据进 行操作。在有些情况下两者可以互换。
 
 */

- (void)gcd_safe {
    [self testLock:1000];
}

/*加解锁效率对比
 
 总结
 
 @synchronized：适用线程不多，任务量不大的多线程加锁；atomic：原子属性，为setter方法加锁 就是用的这个
 NSLock：其实NSLock并没有想象中的那么差，不知道大家为什么不推荐使用
 dispatch_semaphore_t：使用信号来做加锁，性能提升显著
 NSCondition：使用其做多线程之间的通信调用不是线程安全的
 NSConditionLock：单纯加锁性能非常低，比NSLock低很多，但是可以用来做多线程处理不同任务的通信调用
 NSRecursiveLock：递归锁的性能出奇的高，但是只能作为递归使用,所以限制了使用场景
 NSDistributedLock：分布锁，文件方式实现，可以跨进程.因为是MAC开发的，就不讨论了.
 POSIX(pthread_mutex)：底层的api，复杂的多线程处理建议使用，并且可以封装自己的多线程
 OSSpinLock：性能也非常高，可惜出现了线程问题
 dispatch_barrier_async/dispatch_barrier_sync：测试中发现dispatch_barrier_sync比dispatch_barrier_async性能要高.只有用在并发的线程队列中才会有效，因为串行队列本来就是一个一个的执行的，你打断执行一个和插入一个是一样的效果。两个的区别是是否等待任务执行完成。
 
 */

- (void)testLock:(int)count {
    NSTimeInterval begin, end;
    
    /*
     OSSpinLock:自旋锁。自旋锁，和互斥锁类似，都是为了保证线程安全的锁。但二者的区别是不一样的，对于互斥锁，当一个线程获得这个锁之后，其他想要获得此锁的线程将会被阻塞，直到该锁被释放。但自选锁不一样，当一个线程获得锁之后，其他线程将会一直循环在哪里查看是否该锁被释放。所以，此锁比较适用于锁的持有者保存时间较短的情况下。要提的是OSSpinLock已经出现了BUG，导致并不能完全保证是线程安全的。不建议再继续使用，
     
     原因：主要原因发生在低优先级线程拿到锁时，高优先级线程进入忙等(busy-wait)状态，消耗大量 CPU 时间，从而导致低优先级线程拿不到 CPU 时间，也就无法完成任务并释放锁。这种问题被称为优先级反转。
     为什么忙等会导致低优先级线程拿不到时间片？这还得从操作系统的线程调度说起。
     现代操作系统在管理普通线程时，通常采用时间片轮转算法(Round Robin，简称 RR)。每个线程会被分配一段时间片(quantum)，通常在 10-100 毫秒左右。当线程用完属于自己的时间片以后，就会被操作系统挂起，放入等待队列中，直到下一次被分配时间片。
     */
    {
        OSSpinLock lock = OS_SPINLOCK_INIT;
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            OSSpinLockLock(&lock);
            {
                
            }
            OSSpinLockUnlock(&lock);
        }
        end = CACurrentMediaTime();
        BPLog(@"OSSpinLock:               %8.2f ms\n", (end - begin) * 1000);
    }
    
    //dispatch_semaphore：信号量实现加锁（GCD）
    {
        dispatch_semaphore_t lock =  dispatch_semaphore_create(1);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            {
                
            }
            dispatch_semaphore_signal(lock);
        }
        end = CACurrentMediaTime();
        BPLog(@"dispatch_semaphore:       %8.2f ms\n", (end - begin) * 1000);
    }
    
    // pthread_mutex：互斥锁，互斥锁的实现原理与信号量非常相似，不是使用忙等，而是阻塞线程并睡眠，需要进行上下文切换。支持递归锁
    {
        pthread_mutex_t lock;
        pthread_mutex_init(&lock, NULL);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            {
                
            }
            pthread_mutex_unlock(&lock);
        }
        end = CACurrentMediaTime();
        pthread_mutex_destroy(&lock);
        BPLog(@"pthread_mutex:            %8.2f ms\n", (end - begin) * 1000);
    }
    
    //NSCondition：互斥锁和条件锁的结合。同样实现了NSLocking协议，所以它和NSLock一样，也有NSLocking协议的lock和unlock方法，可以当做NSLock来使用解决线程同步问题，用法完全一样。
    {
        NSCondition *lock = [NSCondition new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            {
                
            }
            [lock unlock];
        }
        end = CACurrentMediaTime();
        BPLog(@"NSCondition:              %8.2f ms\n", (end - begin) * 1000);
    }
    
    /*NSLock:对象锁、互斥锁，遵循了NSLocking 协议。只是在内部封装了一个 pthread_mutex。实现了一个简单的互斥锁；接口实际上都是通过NSLocking协议定义的；不能多次调用 lock方法,会造成死锁：由于是互斥锁，当一个线程进行访问的时候，该线程获得锁，其他线程进行访问的时候，将被操作系统挂起，直到该线程释放锁，其他线程才能对其进行访问，从而却确保了线程安全。但是如果连续锁定两次，则会造成死锁问题。那如果想在递归中使用锁，那要怎么办呢，这就用到了 NSRecursiveLock 递归锁。
     NSLock使用宏定义的原因是，OC 内部还有其他几种锁，他们的 lock 方法都是一模一样，仅仅是内部 pthread_mutex 互斥锁的类型不同。通过宏定义，可以简化方法的定义。
     NSLock 比 pthread_mutex 略慢的原因在于它需要经过方法调用，同时由于缓存的存在，多次方法调用不会对性能产生太大的影响。
     */
    
    {
        NSLock *lock = [NSLock new];//获取锁
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];//加锁
            {
                
            }
            [lock unlock];//解锁
        }
        end = CACurrentMediaTime();
        BPLog(@"NSLock:                   %8.2f ms\n", (end - begin) * 1000);
    }
    
    //pthread_mutex 互斥锁（C语言）
    {
        pthread_mutex_t lock;
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&lock, &attr);
        pthread_mutexattr_destroy(&attr);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            {
                
            }
            pthread_mutex_unlock(&lock);
        }
        end = CACurrentMediaTime();
        pthread_mutex_destroy(&lock);
        BPLog(@"pthread_mutex(recursive): %8.2f ms\n", (end - begin) * 1000);
    }
    
    //NSRecursiveLock:递归锁,顾名思义，可以被一个线程多次获得，而不会引起死锁。多次调用不会阻塞已获取该锁的线程。使用锁最容易犯的一个错误就是在递归或循环中造成死锁，将NSLock换成NSRecursiveLock，便可解决问题。
    {
        NSRecursiveLock *lock = [NSRecursiveLock new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            {
                
            }
            [lock unlock];
        }
        end = CACurrentMediaTime();
        BPLog(@"NSRecursiveLock:          %8.2f ms\n", (end - begin) * 1000);
    }
    
    //NSConditionLock:条件锁，可以设置条件
    {
        NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            {
                
            }
            [lock unlock];
        }
        end = CACurrentMediaTime();
        BPLog(@"NSConditionLock:          %8.2f ms\n", (end - begin) * 1000);
    }
    
    //@synchronized:互斥锁，线程锁,线程池
    {
        NSObject *lock = [NSObject new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            @synchronized(lock) {
                
            }
        }
        end = CACurrentMediaTime();
        BPLog(@"@synchronized:            %8.2f ms\n", (end - begin) * 1000);
    }
    
    BPLog(@"---- fin (%d) ----\n\n",count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
