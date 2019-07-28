//
//  BPDesignPatternsTwoDelegateViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/28.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDesignPatternsTwoDelegateViewController.h"
#import "BPMultiDelegateCenter.h"

@interface BPDesignPatternsTwoDelegateViewController ()

@end

@implementation BPDesignPatternsTwoDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BPMultiDelegateCenter shareCenter].delegate = self;
}

- (void)requiredMethod {
    BPLog(@"requiredMethod - 2");
}

- (void)optionalMethod {
    BPLog(@"optionalMethod - 2");
}

@end
