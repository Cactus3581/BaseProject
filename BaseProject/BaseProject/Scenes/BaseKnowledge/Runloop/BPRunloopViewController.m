//
//  BPRunloopViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/31.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRunloopViewController.h"

//http://geek.csdn.net/news/detail/55617
//http://geek.csdn.net/news/detail/56056

@interface BPRunloopViewController ()

@end

@implementation BPRunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{

            }
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
