//
//  BPDesignPatternsBlockViewControllerB.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsBlockViewControllerB.h"

@interface BPDesignPatternsBlockViewControllerB ()

@end

@implementation BPDesignPatternsBlockViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
}

//3：选择时机，让block拿走值。
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.passValueBlock(@"Block");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
