//
//  BPDesignPatternsProtocolViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/2/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDesignPatternsProtocolViewController.h"
#import "BPDesignPatternsProtocolModel.h"

@interface BPDesignPatternsProtocolViewController ()

@end


@implementation BPDesignPatternsProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self use];
}

- (void)use {
    BPDesignPatternsProtocolModel *model = [[BPDesignPatternsProtocolModel alloc] init];
    [model requiredMethod];
    [model optionalMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
