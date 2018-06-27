//
//  BPTableViewNestGestureDetailViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTableViewNestGestureDetailViewController.h"
#import "MJRefresh.h"

static NSString *cell_identifier = @"UITableViewCell";
static NSString *notificationNameFromInsideScrollEnable = @"notificationNameFromInsideScrollEnable";//外部可以滑动，内部互斥
static NSString *notificationNameFromOutsideScrollNotEnable = @"notificationNameFromOutsideScrollNotEnable";//外部不可以滑动，内部互斥

@interface BPTableViewNestGestureDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) BOOL isScrollEnabled;
@end

@implementation BPTableViewNestGestureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollEnabled) name:notificationNameFromOutsideScrollNotEnable object:nil];
    [self initializeViews];
}

- (void)changeScrollEnabled {
    BPLog(@"内部收到可以滑动的通知");
    self.isScrollEnabled = YES;
}

- (void)initializeViews {
    _isScrollEnabled = NO;
    self.view.backgroundColor = kWhiteColor;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.rowHeight = 100;
    _tableView.tableHeaderView = [[UIView alloc] init];
    _tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];//Height = 0 不行
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier];
    [self setUpRefresh];
}

#pragma mark - TableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kWhiteColor;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld区%ld行",indexPath.section,indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isScrollEnabled) {
        if (scrollView.contentOffset.y<=0) {
            //告诉外面：你可以滑动了，我不能滑动了
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameFromInsideScrollEnable object:nil];
            self.isScrollEnabled = NO;
            scrollView.contentOffset = CGPointZero;
        }else {
            //自己可以滑动了，但是外部不能滑动
        }
    }else {
        //BPLog(@"内部不能滑动");
        scrollView.contentOffset = CGPointZero;//这个防止的是上下两个scroll都显示的情况
    }
}

#pragma mark - 集成刷新组件
- (void) setUpRefresh {
    //    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    //    //[self.tableView footerBeginRefreshing];
    //    self.tableView.footerPullToRefreshText = kFooterPullToRefreshText;
    //    self.tableView.footerReleaseToRefreshText = kFooterReleaseToRefreshText;
    //    self.tableView.footerRefreshingText = kFooterRefreshingText;
}

- (void)endFootRefresh {
    //    [self.tableView footerEndRefreshing];
}

- (void)footerRereshing {
    
}

//旋转事件，需要重新计算cell高度
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
