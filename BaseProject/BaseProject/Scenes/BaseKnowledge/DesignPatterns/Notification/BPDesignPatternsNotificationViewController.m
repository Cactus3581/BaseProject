//
//  BPDesignPatternsNotificationViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsNotificationViewController.h"
#import "BPNotificationCenter.h"

static NSString *nofiKey1 = @"system_notificationCenter1";
static NSString *nofiKey2 = @"system_notificationCenter2";
static NSString *nofiKey3 = @"system_notificationCenter3";

@interface BPDesignPatternsNotificationViewController ()
@property (nonatomic, weak) id<NSObject> observer;

@end

@implementation BPDesignPatternsNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}


- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self addObserver]; // 基础使用
                break;
            }
                
            case 1:{
                [self customNotificationCenter]; // 自定义通知机制
                break;
            }
        }
    }
}

#pragma mark - 系统基础API调用：在post所在的线程同步处理
- (void)addObserver {
    
    /*
     
     注册通知
     
     object是要通知的对象，可以为nil。
     字典用来存储发送通知时附带的信息，也可以为nil。
     
     object指发送给某个特定对象通知，当设置为nil时表示所有对象都会通知。那么如果同时设置name和object参数时就必须同时符合这两个条件的观察者才能接收到通知。相反的如果两个参数都为nil那么就是所有观察者都会收到通知。
     
     NSNotificatinonCenter用来管理通知，将观察者注册到NSNotificatinonCenter的通知调度表中，然后发送通知时利用标识符name和object识别出调度表中的观察者，然后调用相应的观察者的方法，即传递消息（在Objective-C中对象调用方法，就是传递消息，消息有name或者selector，可以接受参数，而且可能有返回值），如果是基于block创建的通知就调用NSNotification的block。
     
     一个NSNotificationCenter对象(通知中心)提供了在程序中广播消息的机制，它实质上就是一个通知分发表。这个分发表负责维护为各个通知注册的观察者，并在通知到达时，去查找相应的观察者，将通知转发给他们进行处理。
     

     1. addObserverForName:object:queue:usingBlock:务必处理好内存问题，避免出现循环引用。
     2. 同步，记住通知的发送和处理是在同一个线程中。
     3. 重复注册重复发通知，成对出现移除

     
     */

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:nofiKey1 object:nil];

    // 添加观察者，注意循环引用
    _observer = [[NSNotificationCenter defaultCenter] addObserverForName:nofiKey2 object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        [self handleNotification:notification];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self postNotification];
}

- (void)postNotification {
    // 发送通知
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [[NSNotificationCenter defaultCenter] postNotificationName:nofiKey1 object:@"addObserver" userInfo:@{@"key":@"value"}];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSLog(@"post in thread = %@", [NSThread currentThread]);
                    [[NSNotificationCenter defaultCenter] postNotificationName:nofiKey2 object:nil];
                });
                break;
            }
                
            case 1:{
                [[BPNotificationCenter defaultCenter] postNotificationName:nofiKey3 info:@"附带信息"];
                break;
            }
        }
    }
}

- (void)handleNotification:(NSNotification *)notification {
    NSString *name = [notification name];
    NSString *object = [notification object];
    NSDictionary *userInfoDict = [notification userInfo];
    NSLog(@"名称:%@，对象:%@，获取的值（userInfo）:%@，receive in thread = %@",name,object,userInfoDict,[NSThread currentThread]);
}

- (void)customNotificationCenter {
    [[BPNotificationCenter defaultCenter] addObserverForName:nofiKey3 observer:self usingBlock:^(id info) {
        BPLog(@"自定义广播 info = %@",info);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nofiKey1 object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nofiKey2 object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    BPLog(@"通知控制器销毁了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
