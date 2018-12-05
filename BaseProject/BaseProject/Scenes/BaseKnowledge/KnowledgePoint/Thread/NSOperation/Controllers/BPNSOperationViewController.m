//
//  BPNSOperationViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSOperationViewController.h"

@interface BPNSOperationViewController ()

@end

@implementation BPNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个线程队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 2; //最大并发数
    
    [queue addOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
