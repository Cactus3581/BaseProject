//
//  BPBaseTableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/9.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseTableViewController.h"
#import <Masonry.h>
#import <MJRefresh.h>

@interface BPBaseTableViewController ()<UITableViewDelegate>
@end

@implementation BPBaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)tableViewStyle {
    self = [super init];
    if (self) {
        _tableViewStyle = tableViewStyle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailizeUI];
}

#pragma mark - initialize methods
- (void)initailizeUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - tableView
- (BPBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BPBaseTableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UITableViewStyle)tableViewStyle {
    if (!_tableViewStyle) {
        _tableViewStyle = UITableViewStylePlain;
    }
    return _tableViewStyle;
}

- (void)setOpenRefresh:(BOOL)openRefresh {
    _openRefresh = openRefresh;
    if (openRefresh) {
        [self startOpenHeaderRefresh];
        [self startOpenFooterRefresh];
    }else {
        [self removeHeaderRefresh];
        [self removeFooterRefresh];
    }
}

- (void)setOpenHeaderRefresh:(BOOL)openHeaderRefresh {
    _openHeaderRefresh = openHeaderRefresh;
    if (openHeaderRefresh) {
        [self startOpenHeaderRefresh];
    }else {
        [self removeHeaderRefresh];
    }
}

- (void)setOpenFooerRefresh:(BOOL)openFooterRefresh {
    _openFooterRefresh = openFooterRefresh;
    if (openFooterRefresh) {
        [self startOpenFooterRefresh];
    }else {
        [self removeFooterRefresh];
    }
}

#pragma mark - mj_refresh methods
- (void)startOpenHeaderRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(xw_headerRefresh)];
}

- (void)removeHeaderRefresh {
    [self.tableView.mj_header removeFromSuperview];
}

- (void)startOpenFooterRefresh {
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(xw_footerRefresh)];
}

- (void)removeFooterRefresh {
    [self.tableView.mj_footer removeFromSuperview];
}

- (NSIndexPath *)getIndexPathWithPoint:(CGPoint)point{
    __block NSIndexPath *indexPath = nil;
    point = CGPointMake(point.x, self.tableView.contentOffset.y + point.y);
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            indexPath = [self.tableView indexPathForCell:cell];
        }
    }];
    return indexPath;
}

- (void)refreshDataSuccessed{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)refreshDataFailed{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)dealloc{
    NSLog(@"销毁了,移除通知");
}

@end
