//
//  BPIncludeTableSelfSizeController.m
//  BaseProject
//
//  Created by Ryan on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIncludeTableSelfSizeController.h"
#import "BPIncludeTableSelfSizeHeadCell.h"
#import "BPIncludeTableSelfSizeHeaderView.h"
#import "MJExtension.h"
#import "BPMultiLevelCatalogueModel.h"
#import "BPMultiLevelCatalogueModelDataSource.h"
#import "BPMultiLevelCatalogueModel+BPHeight.h"

#import "NSObject+YYModel.h"
#import "MJExtension.h"

@interface BPIncludeTableSelfSizeController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic,strong) NSArray *arraySource;//显示的数据
@property (nonatomic,strong) BPMultiLevelCatalogueModel *data;//显示的数据
@end

static NSString *cellIdentifier = @"BPIncludeTableSelfSizeHeadCell";
static NSString *headerIdentifier = @"BPIncludeTableSelfSizeHeaderView";

@implementation BPIncludeTableSelfSizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self initializeViews];
    [self addFPSLabel];
}

- (void)handleData {
    self.data = [BPMultiLevelCatalogueModelDataSource handleData];
    self.arraySource = BPValidateArray(_data.array);
}

- (void)initializeViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView = tableView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.backgroundColor = kLevelColor5;
    
    _tableView.estimatedSectionHeaderHeight = 50;
    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedRowHeight = 190;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedSectionFooterHeight = CGFLOAT_MIN;
    _tableView.sectionFooterHeight = 0;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return BPValidateArray(self.arraySource).count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BPMultiLevelCatalogueModel1st *model = BPValidateArrayObjAtIdx(self.arraySource, section);
    return BPValidateArray(model.array_1st).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPIncludeTableSelfSizeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BPIncludeTableSelfSizeHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    BPMultiLevelCatalogueModel1st *model1 = BPValidateArrayObjAtIdx(self.arraySource, indexPath.section);
    BPMultiLevelCatalogueModel2nd *model2 = BPValidateArrayObjAtIdx(model1.array_1st, indexPath.row);
    [cell setModel:model2 indexPath:indexPath showAll:YES];
//    [cell intrinsicContentSize];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPIncludeTableSelfSizeHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!header) {
        header = [BPIncludeTableSelfSizeHeaderView bp_loadInstanceFromNib];
    }
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    [header setModel:sectionModel section:section];
    return header;
}

// 设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)cardViewHeightWithMaxWidth:(CGFloat)maxWidth {
    [self.view layoutIfNeeded];
    return self.tableView.contentSize.height ;
}

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
        //计算旋转之后的宽度并赋值
        CGSize screen = [UIScreen mainScreen].bounds.size;
        //界面处理逻辑
        [self handleData];
        //动画播放完成之后
        if(screen.width > screen.height){
            BPLog(@"横屏");
        }else{
            BPLog(@"竖屏");
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        BPLog(@"动画播放完之后处理");
    }];
}

- (void)dealloc {
    
}

@end
