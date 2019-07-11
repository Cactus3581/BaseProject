//
//  BPCollectionViewNestGestureCategotyDetailController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCollectionViewNestGestureCategotyDetailController.h"
#import "BPCollectionViewNestGestureCategotyDetailTableViewCell.h"
#import "MJRefresh.h"
#import "BPCollectionViewNestGestureCategotyDetailHeader.h"

static NSString *identifier = @"BPCollectionViewNestGestureCategotyDetailTableViewCell";
static NSString *head_identifier = @"BPCollectionViewNestGestureCategotyDetailHeader";

static NSString *notificationNameFromInsideScrollEnable = @"notificationNameFromInsideScrollEnable";//外部可以滑动，内部互斥
static NSString *notificationNameFromOutsideScrollNotEnable = @"notificationNameFromOutsideScrollNotEnable";//外部不可以滑动，内部互斥

@interface BPCollectionViewNestGestureCategotyDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) BOOL isScrollEnabled;
@end

@implementation BPCollectionViewNestGestureCategotyDetailController

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
    self.tableView.rowHeight = 96;
    self.tableView.estimatedRowHeight = 96;
    self.tableView.sectionHeaderHeight = 39;
    self.tableView.estimatedSectionHeaderHeight = 39;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.estimatedSectionFooterHeight = 0.f;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];//Height = 0 不行
    [self.tableView registerNib:[BPCollectionViewNestGestureCategotyDetailTableViewCell bp_loadNib] forCellReuseIdentifier:identifier];
    [self.tableView registerNib:[BPCollectionViewNestGestureCategotyDetailHeader bp_loadNib] forHeaderFooterViewReuseIdentifier:head_identifier];
    [self setUpRefresh];
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPCollectionViewNestGestureCategotyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell setIndexpath:indexPath index:self.index];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPCollectionViewNestGestureCategotyDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:head_identifier];
    return header;
}

- (void)handleData {

}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (!self.isScrollEnabled) {
//        scrollView.contentOffset = CGPointZero;
//        BPLog(@"内部不能滑动");
//    }
//    if (scrollView.contentOffset.y <= 0) {
//        if (!self.fingerIsTouch) {
//            return;
//        }
//        BPLog(@"内部到顶");
//
//        self.isScrollEnabled = NO;
//        scrollView.contentOffset = CGPointZero;
//        [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameFromInsideScrollEnable object:nil];//到顶通知父视图改变状态
//    }
//    BPLog(@"可以滑动");
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isScrollEnabled) {
        if (scrollView.contentOffset.y<=0) {
            //BPLog(@"内部到顶了发通知告知外部可以滑动");
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameFromInsideScrollEnable object:nil];
            self.isScrollEnabled = NO;
            scrollView.contentOffset = CGPointZero;
        }else {
            //BPLog(@"自己可以滑动");
        }
    }else {
        //BPLog(@"内部不能滑动");
        scrollView.contentOffset = CGPointZero;
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
        [self handleData];
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
