//
//  BPGroupTableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/3.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPGroupTableViewController.h"
#import "MJRefresh.h"
/*
 1. cgfloat_min 待商榷
 2. table及cell样式，及点击颜色
 3. 编辑cell
 4. 缺少nib
 */
static NSString *cell_identifier = @"cell";
static NSString *header_identifier = @"header";
static NSString *footer_identifier = @"footer";

static CGFloat headerH = 30;
static CGFloat footerH = 30;
static CGFloat section_headerH = 30;
static CGFloat section_footerH = 30;
static CGFloat cellH = 50;

@interface BPGroupTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation BPGroupTableViewController

#pragma mark - vc system methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Group";
    self.view.backgroundColor = BPGreenColor;
    [self configTableView];
}

#pragma mark - config tableView
- (void)configTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)register_tableView_nib {
    [self.tableView registerNib:[UINib nibWithNibName:cell_identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cell_identifier];
    [self.tableView registerNib:[UINib nibWithNibName:header_identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:header_identifier];
    [self.tableView registerNib:[UINib nibWithNibName:footer_identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:footer_identifier];
}

#pragma mark - tabeview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
    }
    cell.textLabel.text = @"我是cell";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = BPYellowColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellH;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    //UIView *footerView = [[[NSBundle mainBundle] loadNibNamed:placedFooterView_identifier owner:self options:nil] lastObject];
//    UILabel *footerView = [[UILabel alloc] initWithFrame:CGRectZero];
//    footerView.backgroundColor = BPGreenColor;
//    footerView.text = @"我是footer";
//    return footerView;
//}
//
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
//    return section_footerH;
}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    //UIView  *headerView = [[[NSBundle mainBundle] loadNibNamed:calendarFooter_identifier owner:self options:nil] lastObject];
//    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectZero];
//    headerView.backgroundColor = BPRedColor;
//    headerView.text = @"我是header";
//    return headerView;
//}
//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return CGFLOAT_MIN;
    return section_headerH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - view Transition methods
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

#pragma mark - lazy load methods
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        
        /*
        UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerH)];
        headerView.backgroundColor = BPGreenColor;
        headerView.text = @"我是tableHeader";
        UILabel *footerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, footerH)];
        footerView.backgroundColor = BPGreenColor;
        footerView.text = @"我是tablefooter";
        _tableView.tableHeaderView = headerView;
        _tableView.tableFooterView = footerView;
        */
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = BPPurpleColor;
        //[self register_tableView_nib];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
