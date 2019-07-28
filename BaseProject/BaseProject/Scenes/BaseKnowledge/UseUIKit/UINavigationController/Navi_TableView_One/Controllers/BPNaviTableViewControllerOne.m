//
//  BPNaviTableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/2.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPNaviTableViewControllerOne.h"
#import <Masonry.h>

@interface BPNaviTableViewControllerOne ()<UITableViewDataSource, UITabBarDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BPNaviTableViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
     [self initTableView];
    [self configNaviBar];
}

- (void)configNaviBar {

}

#pragma mark 导航栏做动画时的隐藏与显示
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)initTableView {
    [self.view addSubview:self.tableView];
    if (kiOS11) {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }else {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"系统导航栏动画";
    cell.backgroundColor = kRedColor;
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 88.0f;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
