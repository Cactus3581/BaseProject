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
@property (nonatomic, strong) UIImageView *naviImageView;

@end

@implementation BPNaviTableViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
    self.navigationItem.title = @"系统导航栏";
    [self initTableView];
    [self configNaviBar];
}

- (void)configNaviBar {
    if (kiOS11) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"naviBar"]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    //导航栏透明渐变:对self.barImageView.alpha 做出改变
    _naviImageView = self.navigationController.navigationBar.subviews.firstObject;
    _naviImageView.alpha = 0.f;
    
    //shadowImage:是导航栏下面的那根细线，如果不设置则会看到一根线。
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 0) {
        if (offset>=100) {
            _naviImageView.alpha = 1.0f;
        }else {
            _naviImageView.alpha = ABS(offset) / 100.0f;
        }
    }else {
        _naviImageView.alpha = 1.0f;

    }
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
            //make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
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
