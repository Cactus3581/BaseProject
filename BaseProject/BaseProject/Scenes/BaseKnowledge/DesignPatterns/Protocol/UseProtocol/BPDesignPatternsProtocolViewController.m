//
//  BPDesignPatternsProtocolViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/2/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDesignPatternsProtocolViewController.h"
#import "BPDesignPatternsDelegateViewController.h"

@interface BPDesignPatternsProtocolViewController ()<BPDesignPatternsDelegateViewControllerDelegate>//2.2遵守协议
@end

@implementation BPDesignPatternsProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BPDesignPatternsDelegateViewController *vc = [[BPDesignPatternsDelegateViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    //2.1 设置代理
    vc.delegate = self;
}

//2.3实现协议方法
- (NSString *)configDelegate {
    return @"delegate";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

