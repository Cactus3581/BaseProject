//
//  BPDesignPatternsNotificationViewControllerB.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsNotificationViewControllerB.h"

@interface BPDesignPatternsNotificationViewControllerB ()

@end

@implementation BPDesignPatternsNotificationViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
}

//1.1 选择对时机然后发送通知
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //发布通知。@"传值"，@"value"是自定义写的，前后必须写一致。
    [[NSNotificationCenter defaultCenter]postNotificationName:@"传值" object:nil userInfo:@{@"key":@"value"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
