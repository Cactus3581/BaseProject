//
//  BPPlanCalendarViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPPlanCalendarViewController.h"
#import "BPPlanCalendarTableViewCell.h"
#import "BPPlanGeneralTableViewCell.h"
#import "MJRefresh.h"
#import "BPPlanCalendarConfig.h"
#import "BPPlanCalendarSectionFooterView.h"
#import "BPSectionPlacedFooterView.h"
#import "BPPlanCalendarModel.h"
#import "BPCalendar.h"
#import "NSDate+BPExtension.h"
#import "BPCalendarAppearance.h"

static NSString *calendarCell_identifier = @"BPPlanCalendarTableViewCell";
static NSString *generalCell_identifier = @"BPPlanGeneralTableViewCell";
static NSString *calendarFooter_identifier = @"BPPlanCalendarSectionFooterView";
static NSString *placedFooterView_identifier = @"BPSectionPlacedFooterView";

@interface BPPlanCalendarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BPPlanCalendarConfig *requestConfig;
@property (strong, nonatomic) BPPlanCalendarModel *model;
@property (strong, nonatomic) NSMutableArray *calendarArray;
@end

@implementation BPPlanCalendarViewController

#pragma mark - vc system methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Calendar";
    self.courseid = 1;
    [self handleData];
    [self initializeViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - handle data
- (void)handleData {
    __weak typeof(self) weakSelf = self;
    [self.requestConfig handleDataWithId:self.courseid success:^(BPPlanCalendarModel *model) {
        weakSelf.model = model;
        [weakSelf handleCalendarData];
//        [weakSelf.tableView reloadData];
    } failure:^(NSString *error) {
    }];
}

#pragma mark - handle calendar data
- (void)handleCalendarData {
    for (BPPlanCalendarDateModel *dateModel in self.model.planInfo) {
        BPCalendar *calendar = [BPCalendar calendarWithModel:dateModel];
        [calendar configCalendar]; //同步处理数据
        /*
         //异步处理数据
        [calendar configCalendarWithSussess:^{

        } fail:^{

        }];
        */
        [self.calendarArray addObject:calendar];
    }
    [self.tableView reloadData];
}

#pragma mark - config subViews
- (void)initializeViews {
    self.view.backgroundColor = kWhiteColor;
    [self initializeTableView];
}

#pragma mark - config tableView
- (void)initializeTableView {
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];

    self.tableView.estimatedRowHeight = CGFLOAT_MIN;
    self.tableView.estimatedSectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.estimatedSectionFooterHeight = CGFLOAT_MIN;
//    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self register_tableView_nib];
}

- (void)register_tableView_nib {
    [self.tableView registerNib:[BPPlanCalendarTableViewCell bp_loadNib] forCellReuseIdentifier:calendarCell_identifier];
    [self.tableView registerNib:[BPPlanGeneralTableViewCell bp_loadNib] forCellReuseIdentifier:generalCell_identifier];
}

#pragma mark - tabeview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return BPValidateArray(self.model.planInfo).count ? 3 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return BPValidateArray(self.calendarArray).count;
            break;
            
        case 1:
            return BPValidateArray(self.model.generalEventArray).count;
            break;
            
        case 2:
            return BPValidateArray(self.model.quitPlanArray).count;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BPPlanCalendarTableViewCell *calendarCell = [tableView dequeueReusableCellWithIdentifier:calendarCell_identifier forIndexPath:indexPath];
        calendarCell.calendar = self.calendarArray[indexPath.row];
        calendarCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return calendarCell;
    }else {
        BPPlanGeneralTableViewCell *generalCell = [tableView dequeueReusableCellWithIdentifier:generalCell_identifier forIndexPath:indexPath];
        if (indexPath.section == 1) {
            generalCell.model = BPValidateArray(self.model.generalEventArray)[indexPath.row];
        } else if (indexPath.section == 2) {
            generalCell.model = BPValidateArray(self.model.quitPlanArray)[indexPath.row];
        }
        return generalCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            BPCalendar *calendar = self.calendarArray[indexPath.row];
            return calendar.calendarViewHeight;
        }
            break;
        
        case 1:
            return 50.0f;
            break;
            
        case 2:
            return 50.0f;
            break;
            
        default:
            break;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        BPSectionPlacedFooterView *placedFooterView = [BPSectionPlacedFooterView bp_loadInstanceFromNib];
        return placedFooterView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    switch (section) {
            
        case 1:
            return 15.0f;
            break;
            
        default:
            break;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        BPPlanCalendarSectionFooterView *calendarhead = [BPPlanCalendarSectionFooterView bp_loadInstanceFromNib];
        return calendarhead;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 1:{
            BPPlanCalendarGeneralModel *model = BPValidateArray(self.model.generalEventArray)[indexPath.row];
            UIViewController *vc = [[NSClassFromString(model.fileName) alloc] init];
            if (vc) {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 2: {
            //退出计划
        }
            break;
        default:
            break;
    }
}

#pragma mark - view Transition methods
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

}

#pragma mark - lazy load methods
- (NSMutableArray *)calendarArray {
    if (!_calendarArray) {
        _calendarArray = [NSMutableArray array];
    }
    return _calendarArray;
}

- (BPPlanCalendarConfig *)requestConfig {
    if (!_requestConfig) {
        _requestConfig = [[BPPlanCalendarConfig alloc] init];
    }
    return _requestConfig;
}

- (BPPlanCalendarModel *)model {
    if (!_model) {
        _model = [[BPPlanCalendarModel alloc] init];
    }
    return _model;
}

#pragma mark - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
