//
//  BPMainPageSpeakCategotyController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMainPageSpeakCategotyController.h"
#import "BPMainPageSpeakNormalTableViewCell.h"
#import "MJRefresh.h"
#import "BPMainPageSpeakNormalHeader.h"

static NSString *identifier = @"BPMainPageSpeakNormalTableViewCell";
static NSString *head_identifier = @"BPMainPageSpeakNormalHeader";

static NSString *notificationNameFromInsideScrollEnable = @"notificationNameFromInsideScrollEnable";//外部可以滑动，内部互斥
static NSString *notificationNameFromInsideScrollNotEnable = @"notificationNameFromInsideScrollNotEnable";//外部不可以滑动，内部互斥
static NSString *notificationNameFromOutsideScrollNotEnable = @"notificationNameFromOutsideScrollNotEnable";//外部不可以滑动，内部互斥

@interface BPMainPageSpeakCategotyController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *arraySource;//显示的数据
@property (nonatomic,assign) BOOL isScrollEnabled;
@end

@implementation BPMainPageSpeakCategotyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollEnabled) name:notificationNameFromOutsideScrollNotEnable object:nil];
    [self configTableView];
}

#pragma mark - 请求数据
/*集成刷新组件*/
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

- (void)changeScrollEnabled {
    BPLog(@"内部收到可以滑动的通知");
    self.isScrollEnabled = YES;
    if (!self.tableView.scrollEnabled) {
//        self.tableView.scrollEnabled = YES;
    }
}

- (void)configTableView {
    _isScrollEnabled = NO;
    self.view.backgroundColor = kWhiteColor;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.rowHeight = 96;
    self.tableView.estimatedRowHeight = 96;
    self.tableView.sectionHeaderHeight = 39;
    self.tableView.estimatedSectionHeaderHeight = 39;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.estimatedSectionFooterHeight = 0.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;

    //self.tableView.scrollEnabled = NO;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BPMainPageSpeakNormalTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BPMainPageSpeakNormalHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:head_identifier];

    CGRect frame=CGRectMake(0, 0, 0, CGFLOAT_MIN);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:frame];
    [self setUpRefresh];
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPMainPageSpeakNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell setIndexpath:indexPath index:self.index];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPMainPageSpeakNormalHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:head_identifier];
    return header;
}

- (void)handleData {

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isScrollEnabled) {
        scrollView.contentOffset = CGPointZero;
        BPLog(@"内部不能滑动");
    }
    if (scrollView.contentOffset.y <= 0) {
//        if (!self.fingerIsTouch) {
//            return;
//        }
        BPLog(@"内部到顶");

        self.isScrollEnabled = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameFromInsideScrollEnable object:nil];//到顶通知父视图改变状态
    }
    BPLog(@"可以滑动");

}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.isScrollEnabled) {
//        if (scrollView.contentOffset.y<=0) {
////            BPLog(@"内部到顶了发通知告知外部可以滑动");
//            [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameFromInsideScrollEnable object:nil];//到顶通知父视图改变状态
//            self.isScrollEnabled = NO;
//            scrollView.contentOffset = CGPointMake(0, 0);
//            if (scrollView.scrollEnabled) {
////                scrollView.scrollEnabled = NO;
//            }
//
//        }else {
////            BPLog(@"内部没有到顶发通知告知外部自己仍然可以滑动");
//            [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameFromInsideScrollNotEnable object:nil];
//            self.isScrollEnabled = YES;
//            if (!scrollView.scrollEnabled) {
////                scrollView.scrollEnabled = YES;
//            }
//        }
//    }else {
////        BPLog(@"内部没有权利滑动");
//        scrollView.contentOffset = CGPointMake(0, 0);
//        if (scrollView.scrollEnabled) {
////            scrollView.scrollEnabled = NO;
//        }
//    }
//}


- (NSArray *)arraySource {
    if (!_arraySource) {
        _arraySource = [NSArray array];
    }
    return _arraySource;
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
