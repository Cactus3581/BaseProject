//
//  BPTableViewNestGestureViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTableViewNestGestureViewController.h"
#import "BPTableViewNestGestureBottomTableViewCell.h"
#import "BPGestureRecognizerTableView.h"

static NSString *top_cell_identifier = @"UITableViewCell";
static NSString *bottm_cell_identifier = @"BPTableViewNestGestureBottomTableViewCell";

static NSString *notificationNameFromInsideScrollEnable = @"notificationNameFromInsideScrollEnable";//外部可以滑动，内部互斥
static NSString *notificationNameFromOutsideScrollNotEnable = @"notificationNameFromOutsideScrollNotEnable";//外部不可以滑动，内部互斥

@interface BPTableViewNestGestureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,assign) BOOL isScrollEnabled;
@end

@implementation BPTableViewNestGestureViewController

#pragma mark - vc system methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollEnabled) name:notificationNameFromInsideScrollEnable object:nil];
    self.isScrollEnabled = YES;
}

- (void)changeScrollEnabled {
    self.isScrollEnabled = YES;
}

#pragma mark - UITableViewDataSource
// 返回多少组,没实现该方法,默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// 返回第section组中有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:top_cell_identifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = kThemeColor;
        return cell;
    }else {
        BPTableViewNestGestureBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottm_cell_identifier forIndexPath:indexPath];
        return cell;
    }
}

// 设置某行cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    }
    return self.view.height-kCustomNaviHeight-20;
}

#pragma mark - 操作cell时调用的方法
// cell选中时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //反选 点击的时候灰色 返回来的时候又变回白色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y;
    if (scrollView.contentOffset.y >= bottomCellOffset || !self.isScrollEnabled) { //告诉里面：你可以滑动了，我不能滑动了
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameFromOutsideScrollNotEnable object:nil];//到顶通知父视图改变状态
        self.isScrollEnabled = NO;
    }else {
        //一直可以滑动
    }
}

#pragma mark - TableView 属性相关
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.rowHeight = 45;
        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);//分割线内边距//设置分割线的位置
        _tableView.backgroundColor = kWhiteColor;
        if (kiOS11) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:top_cell_identifier];
        [_tableView registerClass:[BPTableViewNestGestureBottomTableViewCell class] forCellReuseIdentifier:bottm_cell_identifier];
    }
    return _tableView;
}

//旋转事件，需要重新计算cell高度
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //计算旋转之后的宽度并赋值
        CGSize screen = [UIScreen mainScreen].bounds.size;
        //界面处理逻辑
        //动画播放完成之后
        if(screen.width > screen.height){
            BPLog(@"横屏");
        }else{
            BPLog(@"竖屏");
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        BPLog(@"动画播放完之后处理");
        [self.tableView reloadData];

    }];
}

#pragma mark - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
