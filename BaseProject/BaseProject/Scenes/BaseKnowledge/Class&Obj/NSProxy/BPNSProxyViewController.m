//
//  BPNSProxyViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/2/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPNSProxyViewController.h"
#import "BPProxyModel.h"

#import "BPObjectComparison.h"
#import "BPProxy.h"
#import "BPWeakProxy.h"
#import "BPHookProxy.h"

@interface BPNSProxyViewController ()

@property (nonatomic, weak) BPWeakProxy *weakProxy;
@property (nonatomic, weak) NSTimer *timer;

@end


@implementation BPNSProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self hook];
//    [self formarding];
//    [self proxyWithObjectComparison];
    [self creatTimer];
}

- (void)hook {
    BPProxyModel *model = [[BPProxyModel alloc] init];
    BPHookProxy *proxy = [[BPHookProxy alloc] initWithObj:model];
    [proxy execute:@"学习 NSProxy"];
}

//NSObject 与 NSProxy 关于消息转发的比较
- (void)proxyWithObjectComparison {
    BPProxyModel *model = [[BPProxyModel alloc] init];
    BPProxy *proxy = [[BPProxy alloc] initWithObj:model];
    BPProxyModel *model1 = [[BPProxyModel alloc] init];
    BPObjectComparison *proxy1 = [[BPObjectComparison alloc] initWithObj:model1];
    NSLog(@"respondsToSelector = %d", [proxy respondsToSelector:@selector(execute:)]);
    NSLog(@"respondsToSelector = %d", [proxy1 respondsToSelector:@selector(execute:)]);
    NSLog(@"isKindOfClass = %d", [proxy isKindOfClass:[BPProxyModel class]]);
    NSLog(@"isKindOfClass = %d", [proxy1 isKindOfClass:[BPProxyModel class]]);
}

// NSProxy 的消息转发，多重继承
- (void)formarding {
    BPProxyModel *model = [[BPProxyModel alloc] init];
    BPProxy *proxy = [[BPProxy alloc] initWithObj:model];
    [proxy execute:@"学习 NSProxy"];
}

//避免循环应用：weakProxy如何释放
- (void)creatTimer {
    BPWeakProxy *weakProxy = [[BPWeakProxy alloc] initWithTarget:self];
    _weakProxy = weakProxy;
    NSString *str = [weakProxy execute2:@"学习 NSProxy"];
    BPLog(@"str = %@",str);

//    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:weakProxy selector:@selector(timerInvoked:) userInfo:nil repeats:YES];
//    _timer = timer;
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (NSString *)execute2:(NSString *)text {
    return @"text";
}

- (void)timerInvoked:(NSTimer *)timer {
    BPLog(@"timer");
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
    _weakProxy = nil;
    BPLog(@"weakProxy = %@",_weakProxy);
}

@end
