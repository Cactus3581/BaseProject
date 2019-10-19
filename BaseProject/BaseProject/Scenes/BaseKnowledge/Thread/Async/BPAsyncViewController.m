//
//  BPAsyncViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/3/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPAsyncViewController.h"

@interface BPAsyncViewController ()

@end

@implementation BPAsyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testAsync];
    [self testAsync1];
    [self async_reloadData];
    
    for (int i = 0; i<6; i++) {
        [self testAsync2WithNumber:i blk:^(NSInteger index) {
            
            BPLog(@"%ld,isMainThread=%d",index,[NSThread isMainThread]);
        }];
    }
}

#pragma mark - 执行顺序
- (void)testAsync2WithNumber:(NSInteger)index blk:(void(^)(NSInteger index))blk {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((6-index) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            blk(index);
        });
    });
}

#pragma mark - 等待 tableView reloadData刷新完成界面
- (void)async_reloadData {
    // [_tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        // _tableView 在这已经刷新完成界面了
    });
}

#pragma mark - 执行顺序
- (void)testAsync {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
}

- (void)testAsync1 {
    NSLog(@"1");
}

@end
