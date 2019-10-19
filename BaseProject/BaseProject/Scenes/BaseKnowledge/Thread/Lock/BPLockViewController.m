//
//  BPLockViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/1/8.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPLockViewController.h"
#import "AFHTTPSessionManager.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <QuartzCore/QuartzCore.h>

static pthread_mutex_t lock;

@interface BPLockViewController ()

@property (atomic,copy) NSString *str;
@property (atomic, assign) int intA;

@end


@implementation BPLockViewController

@synthesize str = _str;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self atomic];
            }
                break;
                
            case 1:{
                [self lock];
            }
                break;
                
            case 2:{
                [self synchronized];
            }
                break;
                
            case 3:{
                [self semaphore];

            }
                break;
                
            case 4:{
                [self recursiveLock];
            }
                break;
                
            case 5:{
                [self condition];
            }
                break;

            case 6:{
                [self conditionLock];
            }
                break;

            case 7:{
                [self OSSpinLock];
            }
                break;

            case 8:{
                [self pthread_mutex];
            }
                break;

            case 9:{
                [self pthread_mutex_recursive];
            }
                break;
                
            case 10:{
                [self deadlock];
            }
                break;
                
            case 11:{
                [self change];
            }
                break;
        }
    }
}


/*
 多线程安全技术：
 锁：
    自旋锁：一直在轮询，此锁比较适用于锁的持有者保存时间较短的情况下。效率高
    互斥锁：不是使用忙等，而是阻塞线程并睡眠，等待唤醒。需要进行上下文切换。可以使用递归锁防止死锁。
 
 一般锁的弊端：死锁。一般情况下，一个线程只能申请一次锁，也只能在获得锁的情况下才能释放锁，多次申请锁或释放未获得的锁都会导致崩溃。假设在已经获得锁的情况下再次申请锁，线程会因为等待锁的释放而进入睡眠状态，因此就不可能再释放锁，从而导致死锁。然而这种情况经常会发生，比如某个函数申请了锁，在临界区内又递归调用了自己。
 
 线程同步：
 信号量的实现原理与互斥锁非常相似，不是使用忙等，而是阻塞线程并睡眠，需要进行上下文切换。
    信号量：
    条件锁（锁和条件的结合）
 
 */

#pragma mark - atomic 内部使用自旋锁

- (void)atomic {
    // atomic通过自旋锁，在运行时保证 set,get方法的原子性。仅仅是保证了set、get方法的原子性。但是仅仅使用atomic并不能保证线程安全。

    

    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.str = @"1";
        NSLog(@"线程1");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"str = %@",self.str);
        NSLog(@"线程2");
    });
}

- (void)setStr:(NSString *)str {
    // atomic 并不是使用的 同步块，而是自旋锁，这里只是模拟。
    @synchronized(self) {
        _str = [str copy];
    }
    
    // lock 缓存在对象的关联链表里
//    spinlock_t lock = propertyLocks[slot];

    OSSpinLock lock;

    OSSpinLockLock(&lock);
    _str = [str copy];
    OSSpinLockUnlock(&lock);
}

- (NSString *)str {
    @synchronized(self) {
        return _str; // getter不需要copy
    }
    
    OSSpinLock lock;
    
    OSSpinLockLock(&lock);
    return _str; // getter不需要copy
    OSSpinLockUnlock(&lock);
}

#pragma mark - NSLock 互斥锁

- (void)lock {
    
    
    /*
     NSLock内部封装了一个 pthread_mutex，类型为PTHREAD_MUTEX_ERRORCHECK。它会损失一定性能换来错误提示。
     
     实现原理：当一个线程进行访问的时候，该线程获得锁，其他线程进行访问的时候，将被操作系统挂起，直到该线程释放锁，其他线程才能对其进行访问，从而却确保了线程安全。

     
     普通互斥锁的弊端：不能连续多次调用 lock（加锁） 方法，会造成死锁，那如果想在递归中使用锁，可以使用 NSRecursiveLock 递归锁。

     NSLock 效率要比 pthread_mutex 慢，原因在于它需要经过方法调用，同时由于缓存的存在，多次方法调用不会对性能产生太大的影响。

     
     */
    
    NSLock *lock = [[NSLock alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        NSLog(@"线程1");
        sleep(2);
        [lock unlock];
        NSLog(@"线程1解锁成功");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        [lock lock];
        
        // tryLock 并不会阻塞线程。[lock tryLock] 能加锁返回 YES，不能加锁返回 NO，然后都会执行后续代码。
        //[lock tryLock];
        
        // 在所指定 Date 之前尝试加锁，会阻塞线程，如果在指定时间之前都不能加锁，则返回 NO，指定时间之前能加锁，则返回 YES。
        //[lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        
        NSLog(@"线程2");
        [lock unlock];
    });
}

#pragma mark - @synchronized 同步块（内部互斥递归锁）

- (void)synchronized {
    
    // 使用了互斥递归锁来实现，@synchronized 后面需要紧跟一个 OC 对象，它实际上是把这个对象当做锁来使用。这是通过一个哈希表来实现的，OC 在底层使用了一个互斥锁的数组(你可以理解为锁池)，通过对对象去哈希值来得到对应的互斥锁。
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self) {
            sleep(2);
            NSLog(@"线程1");
        }
        NSLog(@"线程1解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized(self) {
            NSLog(@"线程2");
        }
    });
    
}

#pragma mark - semaphore 信号量

- (void)semaphore {
    // 线程同步技术，阻塞线程并睡眠，不会忙等。性能高
    // 信号量保存一个全局信号量的值，信号量的初始值，可以用来控制线程并发访问的最大数量，信号量的初始值为x，代表同时只允许x条线程访问资源。
    // 注意dealloc的时候，pv要平衡，恢复信号量的值
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime);
        sleep(2);
        NSLog(@"线程1");
        dispatch_semaphore_signal(signal);
    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"线程2");
        dispatch_semaphore_signal(signal);
    });
}

#pragma mark - NSRecursiveLock 递归锁
- (void)recursiveLock {
    
    // 内部封装了一个 pthread_mutex，类型为PTHREAD_MUTEX_RECURSIVE。
    // 可以在一个线程中重复加锁，而不会因为递归或循环获取锁中引起死锁。NSRecursiveLock 会记录上锁和解锁的次数，当二者平衡的时候，才会释放锁，其它线程才可以上锁成功。避免了NSLock重复上锁导致死锁的问题。可以把NSLock替换为NSRecursiveLock，它俩只是内部类型不同。
    // NSRecursiveLock 与 NSLock 的区别在于内部封装的 pthread_mutex_t 对象的类型不同，前者的类型为 PTHREAD_MUTEX_RECURSIVE。后者的类型为：PTHREAD_MUTEX_ERRORCHECK

    
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            [lock lock];
            if (value > 0) {
                NSLog(@"value:%d", value);
                RecursiveBlock(value - 1);
            }
            [lock unlock];
        };
        RecursiveBlock(2);
    });
}

#pragma mark - NSCondition 条件锁

- (void)condition {
    
    // 内部封装了一个互斥锁（pthread_mutex）和条件变量（pthread_cond_t，条件变量有点像信号量）。解决线程同步问题
    
    NSCondition *lock = [[NSCondition alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        while (!array.count) {
            [lock wait];
        }
        [array removeAllObjects];
        NSLog(@"array removeAllObjects");
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        [lock lock];
        [array addObject:@1];
        NSLog(@"array addObject:@1");
        [lock signal];
        [lock unlock];
    });
}

#pragma mark - NSConditionLock 条件锁

- (void)conditionLock {
    // 它是对NSCondition的进一步封装。可以设置条件值。本质就是一个生产者-消费者模型。
    // 只有 condition 参数与初始化时候的 condition 相等，lock 才能正确进行加锁操作。而 unlockWithCondition: 并不是当 Condition 符合条件时才解锁，而是解锁之后，修改 Condition 的值，这个结论可以从下面的例子中得出。
    
    
    //主线程中，初始化时候的 condition 参数为 0
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 因为加锁的时候 条件变量与初始值不一样，所以加锁失败。locakWhenCondition 与 lock 加锁失败会阻塞线程，所以线程 1 会被阻塞着，而 tryLockWhenCondition 方法就算条件不满足，也会返回 NO，不会阻塞当前线程。
        [lock lockWhenCondition:1];
        NSLog(@"线程1");
        sleep(2);
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        
        // 因为加锁的时候 条件变量与初始值一样，所以加锁成功。
        if ([lock tryLockWhenCondition:0]) {
            NSLog(@"线程2");
            // 解锁成功且改变 Condition 值为 2。
            [lock unlockWithCondition:2];
            NSLog(@"线程2解锁成功");
        } else {
            NSLog(@"线程2尝试加锁失败");
        }
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);//以保证让线程2的代码后执行
        // 加锁条件是 Condition 为 2， 所以线程 3 加锁成功
        if ([lock tryLockWhenCondition:2]) {
            NSLog(@"线程3");
            // 解锁成功且不改变 Condition 值。
            [lock unlock];
            NSLog(@"线程3解锁成功");
        } else {
            NSLog(@"线程3尝试加锁失败");
        }
    });
    
    //线程4
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);//以保证让线程2的代码后执行
        
        // 线程 4 的条件也是 2，所以加锁成功，
        
        if ([lock tryLockWhenCondition:2]) {
            NSLog(@"线程4");
            // 解锁成功且改变 Condition 值为 1。这个时候线程 1 终于可以加锁成功，解除了阻塞。
            [lock unlockWithCondition:1];
            NSLog(@"线程4解锁成功");
        } else {
            NSLog(@"线程4尝试加锁失败");
        }
    });
}

#pragma mark - OSSpinLock 自旋锁
- (void)OSSpinLock {

    // 一直在轮询，而不是像 NSLock 一样先轮询，再 waiting 等唤醒。有安全性问题（优先级反转）。此锁比较适用于锁的持有者保存时间较短的情况下。效率高
    // 互斥锁：阻塞，休眠、等待唤醒，上下文切换
    __block OSSpinLock lock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&lock);
        NSLog(@"线程1");
        sleep(10);
        OSSpinLockUnlock(&lock);
        NSLog(@"线程1解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        OSSpinLockLock(&lock);
        NSLog(@"线程2");
        OSSpinLockUnlock(&lock);
    });
}


#pragma mark - pthread_mutex C 语言下的互斥锁
- (void)pthread_mutex {
    
    // 它是大多数互斥锁的底层实现
    
    /*
    初始化一个锁，传 NULL 为默认类型，一共有 4 种类型。
     PTHREAD_MUTEX_NORMAL：缺省类型，也就是普通锁。当一个线程加锁以后，其余请求锁的线程将形成一个等待队列，并在解锁后先进先出原则获得锁。
  PTHREAD_MUTEX_ERRORCHECK：检错锁，如果同一个线程请求同一个锁，则返回EDEADLK，否则与普通锁类型动作相同。这样就保证当不允许多次加锁时不会出现嵌套情况下的死锁。
     PTHREAD_MUTEX_RECURSIVE：递归锁，允许同一个线程对同一个锁成功获得多次，并通过多次 unlock 解锁。
     PTHREAD_MUTEX_DEFAULT：适应锁，动作最简单的锁类型，仅等待解锁后重新竞争，没有等待队列。
     */


    pthread_mutex_init(&lock, NULL);
    
    pthread_t thread1;
    pthread_create(&thread1, NULL, threadMethord1, NULL);
    
    pthread_t thread2;
    pthread_create(&thread2, NULL, threadMethord2, NULL);
}

void *threadMethord1() {
    pthread_mutex_lock(&lock);
    printf("线程1\n");
    sleep(2);
    pthread_mutex_unlock(&lock);
    printf("线程1解锁成功\n");
    return 0;
}

void *threadMethord2() {
    sleep(1);
    pthread_mutex_lock(&lock);
    printf("线程2\n");
    pthread_mutex_unlock(&lock);
    return 0;
}

#pragma mark - pthread_mutex_recursive C 语言下的互斥锁里的递归锁

- (void)pthread_mutex_recursive {
    pthread_mutex_init(&lock, NULL);
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&lock, &attr);
    pthread_mutexattr_destroy(&attr);
    
    pthread_t thread;
    pthread_create(&thread, NULL, threadMethord, 5);
}

void *threadMethord(int value) {
    pthread_mutex_lock(&lock);
    
    if (value > 0) {
        printf("Value:%i\n", value);
        sleep(1);
        threadMethord(value - 1);
    }
    pthread_mutex_unlock(&lock);
    return 0;
}

#pragma mark - 死锁
- (void)deadlock {
    
    // http://ios.jobbole.com/82622/
    
    //要理解同步异步函数是否返回这句话，返回其实就是指的';'，是否返回跟阻塞其实一回事，直接返回，就不阻塞了，等待返回，就是阻塞；
    
    // 先来看看都有哪些任务加入了Main Queue：【任务1，同步函数、任务3】。
    // 任务1在主线程，主队列中执行；
    BPLog(@"1");
    
    // 任务2
    // 发生死锁：获取主队列，dispatch_sync同步函数将任务2放到主队列里，并阻塞当前线程（在这是主线程）,以及等待任务2返回。
    // 这时候，同步函数阻塞了主线程，同步函数并等待任务2的返回，但是线程都被阻塞了，block没有线程去执行，进入了互相等待的局面，导致死锁；相当于任务和线程之间有个同步函数裁判在阻隔着。
    dispatch_sync(dispatch_get_main_queue(), ^{
        BPLog(@"2");
    });
    
    // 任务3不执行
    BPLog(@"3"); // 任务3
    
    //控制台输出：1
    
    
    // 任务1，顺序执行：任务1在主线程，主队列中执行；
    BPLog(@"1");
    // 任务2，顺序执行：获取全局队列，dispatch_sync同步函数将任务2放到全局队列里，并阻塞当前线程（在这是主线程）,以及等待全局队列里的任务2返回。
    // 这时候，同步函数阻塞了主队列里的主线程，主线程跑到全局队列去执行任务2，同步函数并等待任务2的返回，block块在全局队列里被主线程执行完，返回到主队列；
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        BPLog(@"2");
    });
    // 任务1，顺序执行
    BPLog(@"3");
    
    //控制台输出：1，2，3；
    
    
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    // 任务1，顺序执行：任务1在主线程，主队列中执行；
    BPLog(@"1"); // 任务1
    
    // 异步执行：dispatch_async异步函数将block块任务（里面有三个小任务组成一个大任务）放到串行队列里，不会阻塞当前线程（在这是主线程）,不需要等待串行队列里的任务，直接返回。 这时候，串行队列里，一共有三个任务,串行执行
    dispatch_async(queue, ^{
        // 任务2在串行队列首先执行；
        BPLog(@"2");
        
        // 死锁：dispatch_sync将任务3放到串行队列里，dispatch_sync任务排在任务3的前面 ，此时并阻塞当前线程：任务2->同步函数->任务4->任务3,发生死锁
        dispatch_sync(queue, ^{
            BPLog(@"3"); // 任务3
        });
        BPLog(@"4"); // 任务4
    });
    BPLog(@"5"); // 任务5
    
    // 控制台输出：1，5，2
    
    BPLog(@"1"); // 任务1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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

    // 保证在多线程环境下，只能有一个线程进入。
    
    NSMutableArray *muArray = @[].mutableCopy;
    // 创建为1的信号量
    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 等待信号量
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            [muArray addObject:@(i)];
            NSLog(@"%@",[NSNumber numberWithInt:i]);
            // 发送信号量
            dispatch_semaphore_signal(sem);
        });
    }
}

- (void)change1 {
    /*
     self.intA 是原子操作，但是self.intA = self.intA + 1这个表达式并不是原子操作。 所以线程是不安全的。 threadA 在执行表达式 self.intA之后 self.intA = self.intA + 1;并没有执行完毕 此时threadB 执行self.intA = self.intA + 1; 再回到threadA时，self.intA的数值就被更新了。
     
     不会崩溃，但是最后的值小于预期值。
     */
    
    for (int i = 0; i < 10000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.intA = self.intA + 1;
            BPLog(@"index = %ld",(long)self.intA);
        });
    }
}

#pragma mark - 单例模式下的多线程安全
+ (instancetype)change2 {
    // 这种写法依然不安全，依然可能有多个线程同时通过非空检查，现在它们变成按顺序地创建了多个实例
    static id sharedInstance = nil;
    if (!sharedInstance) {
        @synchronized (self) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

@end
