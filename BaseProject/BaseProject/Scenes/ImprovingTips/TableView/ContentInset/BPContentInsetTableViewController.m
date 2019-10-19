//
//  BPContentInsetTableViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/5/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPContentInsetTableViewController.h"

static NSString *cell_identifier = @"cell";
static NSString *header_identifier = @"header";
static NSString *footer_identifier = @"footer";

@interface BPContentInsetTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation BPContentInsetTableViewController

#pragma mark - vc system methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeTableView];
}

#pragma mark - config tableView
- (void)initializeTableView {
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 10, 10, -10);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(400);
        make.width.mas_equalTo(200);
    }];
}

#pragma mark - tabeview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld区 第%ld个cell",indexPath.section,indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kYellowColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //UIView *headerView = [UIView bp_loadInstanceFromNib];
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectZero];
    headerView.backgroundColor = kRedColor;
    headerView.text = [NSString stringWithFormat:@"我是Section Header:第%ld区",section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

//FIXME: Plain :去掉UItableview headerview黏性(sticky) 去掉header的浮动效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 100;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
    
    BPLog(@"%@,%@,%@",NSStringFromUIEdgeInsets(self.tableView.contentInset),NSStringFromCGRect(self.tableView.frame),NSStringFromCGSize(self.tableView.contentSize));
}

#pragma mark - lazy load methods
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 100)];
        headerView.backgroundColor = kGreenColor;
        headerView.text = @"我是tableHeader";
        _tableView.tableHeaderView = headerView;

        
        UILabel *footerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 100)];

        footerView.backgroundColor = kPurpleColor;
        footerView.text = @"我是tablefooter";
        _tableView.tableFooterView = footerView;
        
        //warning: 注意不能是CGFLOAT_MIN
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = kLightGrayColor;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - dealloc
- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
