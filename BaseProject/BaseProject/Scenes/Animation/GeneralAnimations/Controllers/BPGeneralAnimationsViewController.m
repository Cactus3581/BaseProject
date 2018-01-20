//
//  BPGeneralAnimationsViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/7.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPGeneralAnimationsViewController.h"
#import "BPCircleView.h"

@interface BPGeneralAnimationsViewController ()

@end

@implementation BPGeneralAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureCircleView];

}

- (void)configureCircleView {
    BPCircleView *view = [[BPCircleView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(186.0);
        make.center.equalTo(self.view);
    }];
    [view setTotlaScore:710 score:100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
