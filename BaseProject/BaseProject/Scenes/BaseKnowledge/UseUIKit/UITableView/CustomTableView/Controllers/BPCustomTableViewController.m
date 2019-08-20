//
//  BPCustomTableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCustomTableViewController.h"
#import "BPTableView.h"
#import "BPCustomTableViewCell.h"

@interface BPCustomTableViewController ()<BPTableViewDelegate>

@property (weak, nonatomic) BPTableView *tableView;
@property (assign, nonatomic) NSInteger count;

@end


@implementation BPCustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 50;
    self.rightBarButtonTitle = @"reloadData";
//    BPTableView *tableView = [[BPTableView alloc] init];
    BPTableView *tableView = [[BPTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView = tableView;
    tableView.dataSource = self;
    [tableView registerClass:[BPCustomTableViewCell class] forCellReuseIdentifier:@""];
    [self.view addSubview:tableView];
    
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    _count = 100;
    [_tableView reloadData];
}

- (NSInteger)tableView:(BPTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _count;
}

- (BPCustomTableViewCell *)tableView:(BPTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    cell.label.text = @(indexPath.row).stringValue;
    return cell;
}

- (CGFloat)tableView:(BPTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
