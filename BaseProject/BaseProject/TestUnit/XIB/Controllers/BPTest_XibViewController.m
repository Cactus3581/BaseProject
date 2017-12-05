//
//  BPTest_XibViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/5.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPTest_XibViewController.h"

@interface BPTest_XibViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

static NSString *cell_identifier = @"cell";


static CGFloat cellH = 50;

@implementation BPTest_XibViewController

#pragma mark - vc system methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Group";
    self.view.backgroundColor = kGreenColor;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navi_backImage"] forBarMetrics:UIBarMetricsDefault];
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout =  UIRectEdgeNone;
//    self.navigationController.navigationBar.translucent = NO;
    if (kiOS11) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.bottomView.backgroundColor = kLightGrayColor;
    [self.navigationController.navigationBar setHidden:YES];
    [self configTableView];
    
}

#pragma mark - tabeview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 19;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
    }
    cell.textLabel.text = @"我是cell";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kYellowColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellH;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
    //    return section_footerH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


#pragma mark - lazy load methods
- (void)configTableView {
    _tableView.delegate = (id)self;
    _tableView.dataSource = (id)self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.backgroundColor = kPurpleColor;
}

#pragma mark - dealloc
- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

