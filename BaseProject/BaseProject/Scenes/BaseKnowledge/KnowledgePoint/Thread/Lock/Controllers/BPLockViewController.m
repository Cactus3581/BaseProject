//
//  BPLockViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/8.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPLockViewController.h"
#import "AFHTTPSessionManager.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <QuartzCore/QuartzCore.h>

@interface BPLockViewController ()

@end

@implementation BPLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testLock:1000];
}

- (void)testLock:(int)count {
    NSTimeInterval begin, end;
    
    BPLog(@"---- start (%d) ----\n\n",count);

    /*
     OSSpinLock:自旋锁。自旋锁的目的是为了确保临界区只有一个线程可以访问。
     
     自旋锁和互斥锁类似，都是为了保证线程安全的锁。但二者的区别是不一样的。
     
     对于自旋锁，当一个线程获得锁之后，其他线程将会一直循环在哪里查看是否该锁被释放（也就是会出现忙等，而不是i休眠）。所以，此锁比较适用于锁的持有者保存时间较短的情况下。

     对于互斥锁，当一个线程获得这个锁之后，其他想要获得此锁的线程将会被阻塞，直到该锁被释放。
     
     要提的是OSSpinLock已经出现了BUG，导致并不能完全保证是线程安全的。不建议再继续使用，
     原因：主要原因发生在低优先级线程拿到锁时，高优先级线程进入忙等(busy-wait)状态，消耗大量 CPU 时间，从而导致低优先级线程拿不到 CPU 时间，也就无法完成任务并释放锁。这种问题被称为优先级反转。
     
     为什么忙等会导致低优先级线程拿不到时间片？这还得从操作系统的线程调度说起。
     
     现代操作系统在管理普通线程时，通常采用时间片轮转算法。每个线程会被分配一段时间片，当线程用完属于自己的时间片以后，就会被操作系统挂起，放入等待队列中，直到下一次被分配时间片。
     
     效率高，但是容易出现问题，不推荐使用

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
    
    /*
     dispatch_semaphore：信号量，通过计数器和线程同步实现，不是使用忙等，而是阻塞线程并睡眠。
     
     实现过程：首先会把信号量的值减一，并判断是否大于零。如果大于零，说明不用等待，所以立刻返回。使线程进入睡眠状态，主动让出时间片，这个函数在互斥锁的实现中，也有可能被用到。
     
     主动让出时间片并不总是代表效率高。让出时间片会导致操作系统切换到另一个线程，这种上下文切换通常需要 10 微秒左右，而且至少需要两次切换。如果等待时间很短，比如只有几个微秒，忙等就比线程睡眠更高效。
     
     效率高，推荐使用
     */
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
    
    /*
     pthread_mutex：跨平台，互斥锁，也可以理解为它是大多数其他互斥锁的底层实现，它有很多锁的类型，比如说递归锁。
     
     互斥锁的实现原理：与信号量非常相似，不是使用忙等，而是阻塞线程并睡眠，需要进行上下文切换。
     
     锁的弊端：一般情况下，一个线程只能申请一次锁，也只能在获得锁的情况下才能释放锁，多次申请锁或释放未获得的锁都会导致崩溃。假设在已经获得锁的情况下再次申请锁，线程会因为等待锁的释放而进入睡眠状态，因此就不可能再释放锁，从而导致死锁。
     
     然而这种情况经常会发生，比如某个函数申请了锁，在临界区内又递归调用了自己。
     
     但是pthread_mutex有很多锁的类型，比如说递归锁。使用它的递归锁可以防止死锁。
     
     */
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
    
    /*
     @synchronized：同步块，使用了互斥锁来实现
     
     我们知道 @synchronized 后面需要紧跟一个 OC 对象，它实际上是把这个对象当做锁来使用。这是通过一个哈希表来实现的，OC 在底层使用了一个互斥锁的数组(你可以理解为锁池)，通过对对象去哈希值来得到对应的互斥锁。
    
     */
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
    
    /*
     NSLock:是 OC 以对象的形式暴露给开发者的一种锁，它的实现非常简单，通过宏，定义了 lock 方法。接口实际上都是通过NSLocking协议定义的。只是在内部封装了一个 pthread_mutex，实现了一个简单的互斥锁；
     
     NSLock使用宏定义的原因是，OC 内部还有其他几种锁，他们的 lock 方法都是一模一样，仅仅是内部 pthread_mutex 互斥锁的类型不同。通过宏定义，可以简化方法的定义。
     
     NSLock 比 pthread_mutex 略慢的原因在于它需要经过方法调用，同时由于缓存的存在，多次方法调用不会对性能产生太大的影响。
     
     不能多次调用 lock 方法,会造成死锁：由于是互斥锁，当一个线程进行访问的时候，该线程获得锁，其他线程进行访问的时候，将被操作系统挂起，直到该线程释放锁，其他线程才能对其进行访问，从而却确保了线程安全。但是如果连续锁定两次，则会造成死锁问题。那如果想在递归中使用锁，那要怎么办呢，往后看就会说 NSRecursiveLock 递归锁。

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
    
    /*
     NSRecursiveLock:递归锁，顾名思义，可以被一个线程多次获得，而不会引起死锁。使用锁最容易犯的一个错误就是在递归或循环中造成死锁，将NSLock换成NSRecursiveLock，便可解决问题。
     
     递归锁也是通过 pthread_mutex_lock 函数来实现，在函数内部会判断锁的类型，如果显示是递归锁，就允许递归调用，仅仅将一个计数器加一，锁的释放过程也是同理。
     
     NSRecursiveLock 与 NSLock 的区别在于内部封装的 pthread_mutex_t 对象的类型不同，前者的类型为 PTHREAD_MUTEX_RECURSIVE。
     
     */
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
    
    /*
     pthread_mutex_recursive 互斥锁里的递归锁（C语言）
     
     */
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
    
    /*
     NSCondition：封装了一个互斥锁（也用到了pthread_mutex）和条件变量（pthread_cond_t，条件变量有点像信号量）。同样实现了NSLocking协议，所以它和NSLock一样，也有NSLocking协议的lock和unlock方法，可以当做NSLock来使用解决线程同步问题，用法完全一样。
     */
    
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
    
    /*
    NSConditionLock：条件锁，可以设置条件。
     
    本质就是一个生产者-消费者模型
     
    NSConditionLock 借助 NSCondition 来实现。
     
    */
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
    
    BPLog(@"---- fin (%d) ----\n\n",count);
}

@end
