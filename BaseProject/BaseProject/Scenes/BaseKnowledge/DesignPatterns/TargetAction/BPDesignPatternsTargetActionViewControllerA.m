//
//  BPDesignPatternsTargetActionViewControllerA.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsTargetActionViewControllerA.h"
#import "BPDesignPatternsTargetActionViewControllerB.h"

@interface BPDesignPatternsTargetActionViewControllerA ()

@end

@implementation BPDesignPatternsTargetActionViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    BPDesignPatternsTargetActionViewControllerB *vc = [[BPDesignPatternsTargetActionViewControllerB alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    //5.给secondVC添加方法以及方法执行者
    [vc addTarget:self action:@selector(passValue:)];
}

//6.实现方法
- (void)passValue:(NSString *)string {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
