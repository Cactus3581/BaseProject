//
//  BPDynamicJumpViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDynamicJumpViewController.h"

@interface BPDynamicJumpViewController ()

@end

@implementation BPDynamicJumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"动态跳转2";
    [self handleDynamicJumpData];
}

#pragma mark - 动态跳转1
//接受数据并处理
- (void)handleDynamicJumpData {
    if ([self needDynamicJump]) {
        BPLog(@"%@",self.dynamicJumpDict);
    }
}

#pragma mark - 动态跳转2
- (void)rightBarButtonItemClickAction:(id)sender {
    NSDictionary *dic = @{@"i am key":@"i am value",@"vc":@"BPDynamicJumpViewController"};
    [BPDynamicJumpHelper pushViewControllerWithNavigationController:nil pushType:0 linkData:BPJSON(dic)];
}

- (void)loadWithData:(NSDictionary *)dict {
    BPLog(@"%@",dict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
