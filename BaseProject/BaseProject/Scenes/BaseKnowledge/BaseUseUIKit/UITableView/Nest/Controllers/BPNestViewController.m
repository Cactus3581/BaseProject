//
//  BPNestViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNestViewController.h"
#import "BPNestHeadTableViewCell.h"
#import "BPNestBottomTableViewCell.h"

static NSString *top_cell_identifier = @"BPNestHeadTableViewCell";
static NSString *bottm_cell_identifier = @"BPNestBottomTableViewCell";

@interface BPNestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL isScroll;

@end

@implementation BPNestViewController

#pragma mark - vc system methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus2) name:@"scrollViewDidScroll2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus3) name:@"scrollViewDidScroll3" object:nil];
    self.isScroll = YES;
}

- (void)changeScrollStatus2 {
    self.isScroll = YES;
}

- (void)changeScrollStatus3 {
    self.isScroll = NO;
}

#pragma mark - 注册cell
- (void)register_tableView_nib {
    [self.tableView registerNib:[UINib nibWithNibName:top_cell_identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:top_cell_identifier];
    [self.tableView registerClass:[BPNestBottomTableViewCell class] forCellReuseIdentifier:bottm_cell_identifier];
//        [self.tableView registerNib:[UINib nibWithNibName:header_identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:header_identifier];
    //    [self.tableView registerNib:[UINib nibWithNibName:footer_identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:footer_identifier];
}

#pragma mark - UITableViewDataSource
// 返回多少组,没实现该方法,默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// 返回第section组中有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        BPNestHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:top_cell_identifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = kGreenColor;
        return cell;
    }else {
        BPNestBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottm_cell_identifier forIndexPath:indexPath];
        return cell;
    }
}


// 设置某行cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100;
    }
    return self.view.height-kCustomNaviHeight-20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - 操作cell时调用的方法
// cell选中时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //反选 点击的时候灰色 返回来的时候又变回白色
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y;
    BPLog(@"bottomCellOffset = %.2f",bottomCellOffset);
    if (scrollView.contentOffset.y >= bottomCellOffset|| !self.isScroll) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidScroll1" object:nil];//到顶通知父视图改变状态
    }else {
        
    }
}

#pragma mark - TableView 属性相关
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 45;
        _tableView.sectionHeaderHeight = 45;
        _tableView.sectionFooterHeight = 45;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);//分割线内边距//设置分割线的位置
        //估算高度,默认0
        //warning: 注意不能是CGFLOAT_MIN
        _tableView.estimatedRowHeight = 0; //iOS11之前，默认为0，之后自动计算
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = kExplicitColor;
        [self register_tableView_nib]; //注册cell的时机
        if (kiOS11) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
