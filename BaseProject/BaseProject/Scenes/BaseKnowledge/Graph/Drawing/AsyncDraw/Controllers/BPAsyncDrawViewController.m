//
//  BPAsyncDrawViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/3.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPAsyncDrawViewController.h"
#import "BPAsyncTableView.h"

@interface BPAsyncDrawViewController ()

@end

@implementation BPAsyncDrawViewController {
    BPAsyncTableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tableView = [[BPAsyncTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

