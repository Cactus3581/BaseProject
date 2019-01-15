//
//  BPDesignPatternsNotificationViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsNotificationViewController.h"
#import "BPNotificationCenter.h"
#import "BPAnotherNotificationCenter.h"

static NSString *nofiKey1 = @"system_notificationCenter1";
static NSString *nofiKey2 = @"system_notificationCenter2";
static NSString *nofiKey3 = @"system_notificationCenter3";
static NSString *nofiKey4 = @"system_notificationCenter4";

@interface BPDesignPatternsNotificationViewController ()
@property (nonatomic, weak) id <NSObject> observer;
@property (nonatomic, strong) NSOperationQueue *mainQueue;
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
                [self customNotificationCenter]; // 第一种自定义通知机制
                break;
            }
                
            case 2:{
                [self customAnotherNotificationCenter]; // 第二种通过对象的方式自定义通知机制
                break;
            }
        }
    }
}

#pragma mark - 系统基础API调用
- (void)addObserver {
    
    /*
    
     一个NSNotificationCenter对象(通知中心)提供了在程序中广播消息的机制。
     
     它实质上就是一个通知分发表，这个分发表负责维护为各个通知注册的观察者，并在通知到达时，利用标识符name和object，去查找相应的观察者，将通知转发给观察者进行处理。
     
     注意：
     1. addObserverForName:object:queue:usingBlock:务必处理好内存问题，避免出现循环引用。
     2. 同步并且通知的发送和处理是在同一个线程中。
     3. 重复注册重复发通知，成对出现移除
     4. 返回的_observer到底是什么
     
     */

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:nofiKey1 object:nil];

    // 添加观察者，注意循环引用,在这如果用了_mainQueue，就会发生循环引用
    _mainQueue = [NSOperationQueue mainQueue];
    weakify(self);
    _observer = [[NSNotificationCenter defaultCenter] addObserverForName:nofiKey2 object:nil queue:_mainQueue usingBlock:^(NSNotification *notification) {
         strongify(self);
        [self handleNotification:notification];
    }];
    BPLog(@"_observer = %@, %d",_observer,[_observer isKindOfClass:[self class]]);
}

#pragma mark - 自定义封装通知一
- (void)customNotificationCenter {
    [[BPNotificationCenter defaultCenter] addObserverForName:nofiKey3 observer:self usingBlock:^(id info) {
        BPLog(@"自定义广播一 name = %@, info = %@",nofiKey3,info);
    }];
}

#pragma mark - 自定义封装通知二
- (void)customAnotherNotificationCenter {
    [[BPAnotherNotificationCenter defaultCenter] addObserverForName:nofiKey4 observer:self usingBlock:^(id info) {
        BPLog(@"自定义广播二 name = %@, info = %@",nofiKey4,info);
    }];
}

#pragma mark - 接受的通知都在这
- (void)postNotification {

    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        
        switch (type) {
                
            case 0:{
                [[NSNotificationCenter defaultCenter] postNotificationName:nofiKey1 object:nil userInfo:@{@"key":@"value"}];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    BPLog(@"post in thread = %@", [NSThread currentThread]);
                    [[NSNotificationCenter defaultCenter] postNotificationName:nofiKey2 object:nil];
                });
                break;
            }
                
            case 1:{
                [[BPNotificationCenter defaultCenter] postNotificationName:nofiKey3 info:@"附带信息：自定义通知一"];
                break;
            }
                
            case 2:{
                [[BPAnotherNotificationCenter defaultCenter] postNotificationName:nofiKey4 info:@"附带信息：自定义通知二"];
                break;
            }
        }
    }
}

- (void)handleNotification:(NSNotification *)notification {
    NSString *name = [notification name];
    NSString *object = [notification object];
    NSDictionary *userInfoDict = [notification userInfo];
    BPLog(@"名称:%@，对象:%@，获取的值（userInfo）:%@，receive in thread = %@",name,object,userInfoDict,[NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self postNotification];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nofiKey1 object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nofiKey2 object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 以下自定义的不需要释放了，因为mapTable会随着观察者（在这里就是self）自动释放，mapTable里存放的self、事件,也会随着释放
    [[BPNotificationCenter defaultCenter] removeObserver:self name:nofiKey3];
    [[BPNotificationCenter defaultCenter] removeObserver:self];

    [[BPAnotherNotificationCenter defaultCenter] removeObserver:self name:nofiKey4];
    [[BPAnotherNotificationCenter defaultCenter] removeObserver:self];

    BPLog(@"通知控制器销毁了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
