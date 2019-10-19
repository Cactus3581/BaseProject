//
//  BPNSOperationViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/3/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSOperationViewController.h"
#import "BPSubOperation.h"

@interface BPNSOperationViewController ()
@property (nonatomic,assign) NSInteger ticketSurplusCount;
@property (nonatomic,strong) NSLock *lock;
@end

@implementation BPNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self useInvocationOperation]; // 在当前线程使用子类 NSInvocationOperation
            }
                break;
                
            case 1:{
                [self useInvocationOperationInOtherThread]; // 在其他线程使用子类 NSInvocationOperation
            }
                break;
                
            case 2:{
                [self useBlockOperation]; // 在当前线程使用 NSBlockOperation,及AddExecutionBlock方法
                
            }
                break;
                
            case 3:{
                [self useCustomOperation];//使用自定义继承自 NSOperation 的子类
            }
                break;
                
            case 4:{
                [self addOperationToQueue];//使用addOperation: 添加操作到队列中
                
            }
                break;
                
            case 5:{
                [self addOperationWithBlockToQueue];//使用 addOperationWithBlock: 添加操作到队列中
            }
                break;
                
            case 6:{
                [self setMaxConcurrentOperationCount];//设置最大并发操作数（MaxConcurrentOperationCount）
            }
                break;
                
            case 7:{
                [self addDependency];//添加依赖
            }
                break;
                
            case 8:{
                [self setQueuePriority];//设置优先级（queuePriority）
            }
                break;
                
            case 9:{
                [self communication];//线程间的通信
            }
                break;
                
            case 10:{
                [self completionBlock];//完成操作
            }
                break;
                
            case 11:{
                [self initTicketStatusSave];//线程安全
            }
                break;
                
            case 12:{
                [self basal_operation];//常用属性和方法
            }
                break;
                
            case 13:{
                [self change];//面试题
            }
                break;
        }
    }
}

/*
 NSOperation：NSOperation 是个抽象类，不能用来封装操作。我们只有使用它的子类来封装操作：NSInvocationOperation、NSBlockOperation，、自定义子类
 
 NSOperationQueue：主队列、自定义队列。主队列运行在主线程之上，而自定义队列在后台执行。
 
 NSOperation 需要配合 NSOperationQueue 来实现多线程。因为默认情况下，NSOperation 单独使用时系统同步执行操作，配合 NSOperationQueue 我们能更好的实现异步执行。

 */

#pragma mark - 单独使用NSOperation进行同步操作（在主线程） - 子类 NSInvocationOperation
/*
 在没有使用 NSOperationQueue、在主线程中单独使用使用子类 NSInvocationOperation 执行一个操作的情况下，操作是在当前线程执行的，并没有开启新线程。
 */
- (void)useInvocationOperation {
    // 1.创建 NSInvocationOperation 对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    // 2.调用 start 方法开始执行操作
    [op start];
}

/**
 * 任务1
 */
- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
        BPLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
}


#pragma mark - 单独使用NSOperation进行同步操作（在子线程） - 子类 NSInvocationOperation
/*
 在其他线程中单独使用子类 NSInvocationOperation，操作是在当前调用的其他线程执行的，并没有开启新线程。
 */

- (void)useInvocationOperationInOtherThread {
    // 在其他线程使用子类 NSInvocationOperation
    [NSThread detachNewThreadSelector:@selector(useInvocationOperation) toTarget:self withObject:nil];
}

#pragma mark - 单独使用NSOperation进行同步操作 - 子类 NSBlockOperation
/*
 和上边 NSInvocationOperation 使用一样。因为代码是在主线程中调用的，所以打印结果为主线程。如果在其他线程中执行操作，则打印结果为其他线程。（在不使用addExecutionBlock的环境下，下面会讲到）
 
 但是，NSBlockOperation 还提供了一个方法 addExecutionBlock:，通过 addExecutionBlock: 就可以为 NSBlockOperation 添加额外的操作。
 
 如果添加的操作多的话，blockOperationWithBlock: 中的操作也可能会在其他线程（非当前线程）中执行，这是由系统决定的，并不是说添加到 blockOperationWithBlock: 中的操作一定会在当前线程中执行。（可以使用 addExecutionBlock: 多添加几个操作试试）。
 
 一般情况下，如果一个 NSBlockOperation 对象封装了多个操作。NSBlockOperation 是否开启新线程，取决于操作的个数。如果添加的操作的个数多，就会自动开启新线程。当然开启的线程数是由系统来决定的。

 */
- (void)useBlockOperation {
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    
    // 2.调用 start 方法开始执行操作
    [op start];
}

#pragma mark - 使用自定义继承自 NSOperation 的子类

- (void)useCustomOperation {
    // 1.创建 BPSubOperation 对象
    BPSubOperation *op = [[BPSubOperation alloc] init];
    // 2.调用 start 方法开始执行操作
    [op start];
}

#pragma mark - 创建队列实现多线程并发，使用 addOperation: 将操作加入到操作队列中

- (void)addOperationToQueue {
    
    // 主队列获取方法
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];//凡是添加到主队列中的操作，都会放到主线程中执行。
    
    // 1.创建自定义队列（非主队列）：添加到这种队列中的操作，就会自动放到子线程中执行；同时包含了：串行、并发功能；
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作
    // 使用 NSInvocationOperation 创建操作1
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    // 使用 NSInvocationOperation 创建操作2
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    // 使用 NSBlockOperation 创建操作3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.使用 addOperation: 添加所有操作到队列中
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
    [queue addOperation:op3]; // [op3 start]
}

/**
 * 任务2
 */
- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:0.2];              // 模拟耗时操作
        BPLog(@"2---%@", [NSThread currentThread]);     // 打印当前线程
    }
}

#pragma mark - 创建队列实现多线程并发，使用 addOperationWithBlock: 将操作加入到操作队列中

- (void)addOperationWithBlockToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.使用 addOperationWithBlock: 添加操作到队列中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

#pragma mark - 设置 MaxConcurrentOperationCount（最大并发操作数），实现串行和并发

/*
 maxConcurrentOperationCount 控制的不是并发线程的数量，而是一个队列中同时能并发执行的最大操作数。而且一个操作也并非只能在一个线程中运行。
 
 默认情况下为-1，表示不进行限制，可进行并发执行。
 为1时，队列为串行队列。只能串行执行。
 大于1时，队列为并发队列。操作并发执行，当然这个值不应超过系统限制，即使自己设置一个很大的值，系统也会自动调整为 min{自己设定的值，系统设定的默认最大值}。
 
 */
- (void)setMaxConcurrentOperationCount {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.设置最大并发操作数
    queue.maxConcurrentOperationCount = 1; // 串行队列
    // queue.maxConcurrentOperationCount = 2; // 并发队列
    // queue.maxConcurrentOperationCount = 8; // 并发队列
    
    // 3.添加操作
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

#pragma mark - 操作依赖，通过操作依赖，我们可以很方便的控制操作之间的执行先后顺序

/*
 三个API：addDependency;removeDependency;dependencies
 
 */
- (void)addDependency {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2
    
    //[op2 removeDependency:op1]; // op2 移除 op1 的依赖
    
    //op2.dependencies; //在当前操作开始执行之前完成执行的所有操作对象数组

    // 4.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
}

#pragma mark - 设置优先级（queuePriority）

/*
 queuePriority属性适用于同一操作队列中的操作，不适用于不同操作队列中的操作。默认情况下，所有新创建的操作对象优先级都是NSOperationQueuePriorityNormal。但是我们可以通过setQueuePriority:方法来改变当前操作在同一队列中的执行优先级。
 
 对于添加到队列中的操作，首先进入准备就绪的状态（就绪状态取决于操作之间的依赖关系），然后进入就绪状态的操作的开始执行顺序（非结束执行顺序）由操作之间相对的优先级决定（优先级是操作对象自身的属性）。
 
 就绪状态下，优先级高的会优先执行，但是执行时间长短并不是一定的，所以优先级高的并不是一定会先执行完毕

 */
- (void)setQueuePriority {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 2; i++) {
            BPLog(@"1-----%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.2];
        }
    }];
    
    [op1 setQueuePriority:(NSOperationQueuePriorityVeryLow)];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 2; i++) {
            BPLog(@"2-----%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.2];
        }
    }];
    
    [op2 setQueuePriority:(NSOperationQueuePriorityVeryHigh)];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
}

#pragma mark - 线程间通信

- (void)communication {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 异步进行耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 进行一些 UI 刷新等操作
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
                BPLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
    }];
}

#pragma mark - 完成操作 completionBlock

- (void)completionBlock {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2];          // 模拟耗时操作
            BPLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.添加完成操作
    op1.completionBlock = ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2];          // 模拟耗时操作
            BPLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    };
    
    // 4.添加操作到队列中
    [queue addOperation:op1];
}

#pragma mark - 线程安全：给线程加锁

/**
 * 线程安全：使用 NSLock 加锁，在一个线程执行该操作的时候，不允许其他线程进行操作
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */

- (void)initTicketStatusSave {
    BPLog(@"currentThread---%@",[NSThread currentThread]); // 打印当前线程
    
    self.ticketSurplusCount = 50;
    
    self.lock = [[NSLock alloc] init];  // 初始化 NSLock 对象
    
    // 1.创建 queue1,queue1 代表北京火车票售卖窗口
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;
    
    // 2.创建 queue2,queue2 代表上海火车票售卖窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;
    
    // 3.创建卖票操作 op1
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    // 4.创建卖票操作 op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    // 5.添加操作，开始卖票
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        
        // 加锁
        [self.lock lock];
        
        if (self.ticketSurplusCount > 0) {
            //如果还有票，继续售卖
            self.ticketSurplusCount--;
            BPLog(@"%@", [NSString stringWithFormat:@"剩余票数:%ld 窗口:%@", (long)self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }
        
        // 解锁
        [self.lock unlock];
        
        if (self.ticketSurplusCount <= 0) {
            BPLog(@"所有火车票均已售完");
            break;
        }
    }
}

#pragma mark - 常用属性和方法

- (void)basal_operation {
#pragma mark - NSOperation 常用属性和方法
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    NSInvocationOperation *op5 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    NSInvocationOperation *op6 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];

    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
    [queue addOperation:op6];

    
    //取消操作方法
    [op6 cancel];//可取消操作，实质是标记 isCancelled 状态。
    
    //判断操作状态方法
    [op5 isFinished]; //判断操作是否已经结束。
    
    [op6 isCancelled]; //判断操作是否已经标记为取消。
    
    [op5 isExecuting]; //判断操作是否正在在运行。
    
    [op5 isReady]; //判断操作是否处于准备就绪状态，这个值和操作的依赖关系相关
    
    //操作同步
    [op5 waitUntilFinished]; //阻塞当前线程，直到该操作结束。可用于线程执行顺序的同步。
    
    [op1 setCompletionBlock:^{
        BPLog(@"op1 completion");
    }];//会在当前操作执行完毕时执行 completionBlock。
    
    [op1 addDependency:op2]; //添加依赖，使当前操作依赖于操作 op 的完成。
    [op3 addDependency:op2]; //添加依赖，使当前操作依赖于操作 op 的完成。

    [op3 removeDependency:op2];// 移除依赖，取消当前操作对操作 op 的依赖。
    
    NSArray *dependencies = op1.dependencies;
    BPLog(@"dependencies = %@",dependencies);//在当前操作开始执行之前完成执行的所有操作对象数组
    
#pragma mark - NSOperationQueue 常用属性和方法
    
    //添加/获取操作
    [queue addOperationWithBlock:^{
        BPLog(@"添加操作");
    }]; //向队列中添加一个 NSBlockOperation 类型操作对象。
    
    // 使用 NSBlockOperation 创建操作4
    NSBlockOperation *op7 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:0.2]; // 模拟耗时操作
            BPLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    NSArray *operations = [queue operations]; //当前在队列中的操作数组（某个操作执行结束后会自动从这个数组清除）
    BPLog(@"operations = %@",operations);

    NSUInteger operationCount = [queue operationCount];//当前队列中的操作数
    BPLog(@"operationCount = %ld",operationCount);
    
    NSArray *ops = @[op7];
    [queue addOperations:ops waitUntilFinished:YES]; //向队列中添加操作数组，wait 标志是否阻塞当前线程直到所有操作结束
    
    //取消/暂停/恢复操作
    [queue cancelAllOperations]; //可以取消队列的所有操作。
    
    BOOL isSuspended = [queue isSuspended]; //判断队列是否处于暂停状态。 YES 为暂停状态，NO 为恢复状态。
    BPLog(@"isSuspended = %ld",(long)isSuspended);
    
    [queue setSuspended:YES]; //可设置操作的暂停和恢复，YES 代表暂停队列，NO 代表恢复队列。
    
    //操作同步
    [queue waitUntilAllOperationsAreFinished]; //阻塞当前线程，直到队列中的操作全部执行完毕。
    
    //获取队列
    NSOperationQueue *currentQueue = [NSOperationQueue currentQueue];//获取当前队列，如果当前线程不是在 NSOperationQueue 上运行则返回 nil。
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];//获取主队列
}

#pragma mark - 面试题
- (void)change {
    //创建一个并发队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];

    queue.maxConcurrentOperationCount = 2; //最大并发数
    
    [queue addOperationWithBlock:^{
        BPLog(@"%@",[NSThread currentThread]);
        [queue addOperationWithBlock:^{
            sleep(1);
            printf("1");
        }];
        printf("2");
        [queue addOperationWithBlock:^{
            printf("3");
        }];
        
    }];
    sleep(2);
    // 2，3，1
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
