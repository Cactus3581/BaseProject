//
//  BPOptimizeTableViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPOptimizeTableViewController.h"
#import "YYFPSLabel.h"
#import "BPOptimizeTableViewCell.h"

/*
 GPU优化
 1. 圆角：避免离屏渲染，GPU优化
 
 CPU优化
 1. 行高计算
 
 ps：
 1. UIBezierPath
 
 */
@interface BPOptimizeTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BPOptimizeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [UITableView new];
    tableView.rowHeight = widthRatio(120);
    tableView.backgroundColor = kWhiteColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addFPSLabel];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [BPOptimizeTableViewCell bp_cellWithTableView:tableView imageURL:[NSString stringWithFormat:@"https://oepjvpu5g.qnssl.com/avatar%zd.jpg", indexPath.row % 20]];
}

@end
