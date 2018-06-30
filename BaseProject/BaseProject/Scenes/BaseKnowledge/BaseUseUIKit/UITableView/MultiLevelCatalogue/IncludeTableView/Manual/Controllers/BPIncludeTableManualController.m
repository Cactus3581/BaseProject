//
//  BPIncludeTableManualController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIncludeTableManualController.h"
#import "BPIncludeTableManualHeightHelper.h"
#import "BPIncludeTableManualHeadCell.h"
#import "BPIncludeTableManualHeaderView.h"
#import "BPMultiLevelCatalogueModel.h"
#import "BPMultiLevelCatalogueModelDataSource.h"
#import "BPMultiLevelCatalogueModel+BPHeight.h"

@interface BPIncludeTableManualController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic,strong) NSArray *arraySource;//显示的数据
@property (nonatomic,strong) BPMultiLevelCatalogueModel *data;//显示的数据
@property (nonatomic,assign) CGFloat sectionHeight;//去除plain样式 头停留
@property (nonatomic,assign) BOOL isShowAll;
@end

static NSInteger limitNumber = 2;
static NSString *cellIdentifier = @"BPIncludeTableManualHeadCell";
static NSString *headerIdentifier = @"BPIncludeTableManualHeaderView";

@implementation BPIncludeTableManualController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self initializeViews];
    [self addFPSLabel];
}

- (void)handleData {
    self.data = [BPMultiLevelCatalogueModelDataSource handleData];
    [BPIncludeTableManualHeightHelper handleData:_data];
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
    
    //self.tableView.bounces = NO;
    //self.tableView.scrollEnabled = NO;
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if (self.isShowAll) {
//        return BPValidateArray(self.arraySource).count;
//    }else {
//        return BPValidateArray(self.arraySource).count > limitNumber ?  limitNumber : BPValidateArray(self.arraySource).count;
//    }
    return BPValidateArray(self.arraySource).count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BPMultiLevelCatalogueModel1st *model = BPValidateArrayObjAtIdx(self.arraySource, section);
//    if (self.isShowAll) {
//        return BPValidateArray(model.array_1st).count;
//    }else {
//        return BPValidateArray(model.array_1st).count > limitNumber ?  limitNumber : BPValidateArray(model.array_1st).count;
//    }
    return BPValidateArray(model.array_1st).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,indexPath.section);
    BPMultiLevelCatalogueModel2nd *model = BPValidateArrayObjAtIdx(sectionModel.array_1st, indexPath.row);
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPIncludeTableManualHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BPIncludeTableManualHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    BPMultiLevelCatalogueModel1st *model1 = BPValidateArrayObjAtIdx(self.arraySource, indexPath.section);
    BPMultiLevelCatalogueModel2nd *model2 = BPValidateArrayObjAtIdx(model1.array_1st, indexPath.row);
    [cell setModel:model2 indexPath:indexPath showAll:self.isShowAll];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    self.sectionHeight = sectionModel.headerHeight;
    return sectionModel.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPIncludeTableManualHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!header) {
        header = [[[NSBundle mainBundle] loadNibNamed:@"BPIncludeTableManualHeaderView" owner:nil options:nil] firstObject];
    }
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    [header setModel:sectionModel section:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)cardViewHeightWithMaxWidth:(CGFloat)maxWidth {
    [self.view layoutIfNeeded];
    return self.tableView.contentSize.height;
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
