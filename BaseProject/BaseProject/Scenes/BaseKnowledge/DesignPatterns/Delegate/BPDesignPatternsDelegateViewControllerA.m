//
//  BPDesignPatternsDelegateViewControllerA.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsDelegateViewControllerA.h"
#import "BPDesignPatternsDelegateViewControllerB.h"

@interface BPDesignPatternsDelegateViewControllerA ()<BPDesignPatternsDelegateViewControllerDelegate>//2.2遵守协议
@end

@implementation BPDesignPatternsDelegateViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    BPDesignPatternsDelegateViewControllerB *vc = [[BPDesignPatternsDelegateViewControllerB alloc] init];
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
