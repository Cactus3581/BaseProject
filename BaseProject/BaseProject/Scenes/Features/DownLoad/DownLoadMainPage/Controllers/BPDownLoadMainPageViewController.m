//
//  BPDownLoadMainPageViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDownLoadMainPageViewController.h"
#import "BPDownLoadOneFileViewController.h"
#import "BPDownLoadMoreFilesViewController.h"
#import "BPDownLoadMacro.h"
#import "BPDownLoadDataSource.h"

@interface BPDownLoadMainPageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *array;

@end

@implementation BPDownLoadMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self initializeViews];
}

- (void)handleData {
    self.array =  @[@"单个文件下载",@"批量文件下载"];
}

- (void)initializeViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        BPDownLoadOneFileViewController *vc = [[BPDownLoadOneFileViewController alloc] init];
        vc.leftBarButtonTitle = @"单个文件下载";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        BPDownLoadMoreFilesViewController *vc = [[BPDownLoadMoreFilesViewController alloc] init];
        vc.leftBarButtonTitle = @"批量下载";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
