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

- (instancetype)initWithTableStyle:(UITableViewStyle)tableViewStyle {
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
    }
    return _tableView;
}

- (UITableViewStyle)tableViewStyle {
    if (!_tableViewStyle) {
        _tableViewStyle = UITableViewStylePlain;
    }
    return _tableViewStyle;
}

- (void)setRefresh:(BOOL)refresh {
    _refresh = refresh;
    if (refresh) {
        [self setUpHeaderRefresh];
        [self setUpFooterRefresh];
    }else {
        [self removeHeaderRefresh];
        [self removeFooterRefresh];
    }
}

- (void)setHeaderRefresh:(BOOL)headerRefresh {
    _headerRefresh = headerRefresh;
    if (headerRefresh) {
        [self headerRefresh];
    }else {
        [self removeHeaderRefresh];
    }
}

- (void)setFooerRefresh:(BOOL)footerRefresh {
    _footerRefresh = footerRefresh;
    if (footerRefresh) {
        [self footerRefresh];
    }else {
        [self removeFooterRefresh];
    }
}

#pragma mark - mj_refresh methods
- (void)setUpHeaderRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
}

- (void)removeHeaderRefresh {
    [self.tableView.mj_header removeFromSuperview];
}

- (void)setUpFooterRefresh {
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
}

- (void)footerRefreshAction {
    
}

- (void)headerRefreshAction {
    
}
- (void)removeFooterRefresh {
    [self.tableView.mj_footer removeFromSuperview];
}


- (void)endHeaderRefreshing {
    [self.tableView.mj_header endRefreshing];

}

- (void)endFooterRefreshing {
    [self.tableView.mj_footer endRefreshing];

}
- (void)refreshDataSuccessed {
    [self endHeaderRefreshing];
    [self endFooterRefreshing];
    [self reloadData];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)refreshDataFailed {
    [self endHeaderRefreshing];
    [self endFooterRefreshing];
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

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)dealloc{
    NSLog(@"销毁了,移除通知");
}

@end
