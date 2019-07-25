//
//  BPDesignPatternsDelegateViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsDelegateViewController.h"
#import "BPDesignPatternsProtocol.h"


@interface BPDesignPatternsDelegateViewController ()<BPDesignPatternsProtocol>

@end

@implementation BPDesignPatternsDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//选择时机,通知代理执行协议中的方法。
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_delegate && [_delegate respondsToSelector:@selector(useDelegate:)]) {
        NSString *str = [_delegate useDelegate:@"delagete"];
        BPLog(@"%@",str);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
