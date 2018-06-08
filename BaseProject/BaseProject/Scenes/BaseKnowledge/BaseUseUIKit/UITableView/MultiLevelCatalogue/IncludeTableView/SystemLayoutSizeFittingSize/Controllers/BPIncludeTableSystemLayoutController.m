//
//  BPIncludeTableSystemLayoutController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIncludeTableSystemLayoutController.h"
#import "BPIncludeTableSystemLayoutHeadCell.h"
#import "BPIncludeTableSystemLayoutHeaderView.h"
#import "MJExtension.h"
#import "BPMultiLevelCatalogueModel.h"
#import "BPMultiLevelCatalogueModelDataSource.h"
#import "BPMultiLevelCatalogueModel+BPHeight.h"

#import "NSObject+YYModel.h"
#import "MJExtension.h"
#import "UITableView+FDTemplateLayoutCell.h"


static NSInteger limitNumber = 2;
@interface BPIncludeTableSystemLayoutController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic,strong) NSArray *arraySource;//显示的数据
@property (nonatomic,strong) BPMultiLevelCatalogueModel *data;//显示的数据
@property (nonatomic,assign) BOOL isShowAll;
@end

static NSString *cellIdentifier = @"BPIncludeTableSystemLayoutHeadCell";
static NSString *headerIdentifier = @"BPIncludeTableSystemLayoutHeaderView";

@implementation BPIncludeTableSystemLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowAll = YES;
    [self handleData];
    [self configTableView];
}

- (void)handleData {
    self.data = [BPMultiLevelCatalogueModelDataSource handleData];
    self.arraySource = BPValidateArray(_data.array);
}

- (void)configTableView {
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
    _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    
//    _tableView.estimatedRowHeight = 0;
//    _tableView.rowHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.sectionHeaderHeight = 0;    
//    _tableView.estimatedSectionFooterHeight = 0;
//    _tableView.sectionFooterHeight = 0;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //fd template layout cell需要注册
    //[self.tableView registerClass:[BPIncludeTableSystemLayoutHeadCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - TableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return BPValidateArray(self.arraySource).count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BPMultiLevelCatalogueModel1st *model = BPValidateArrayObjAtIdx(self.arraySource, section);
    //    if (self.isShowAll) {
    //        return BPValidateArray(model.array_1st).count;
    //    }else {
    //        return BPValidateArray(model.array_1st).count > limitNumber ?  limitNumber : BPValidateArray(model.array_1st).count;
    //    }
    return BPValidateArray(model.array_1st).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPIncludeTableSystemLayoutHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BPIncludeTableSystemLayoutHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    BPMultiLevelCatalogueModel1st *model1 = BPValidateArrayObjAtIdx(self.arraySource, indexPath.section);
    BPMultiLevelCatalogueModel2nd *model2 = BPValidateArrayObjAtIdx(model1.array_1st, indexPath.row);
    [cell setModel:model2 indexPath:indexPath showAll:self.isShowAll];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPIncludeTableSystemLayoutHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!header) {
        header = [[[NSBundle mainBundle] loadNibNamed:headerIdentifier owner:nil options:nil] firstObject];
    }
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    [header setModel:sectionModel section:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static BPIncludeTableSystemLayoutHeadCell *cell;
    static dispatch_once_t onceToken;
    //必须使用
    dispatch_once(&onceToken, ^{
        cell = [[BPIncludeTableSystemLayoutHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    });
    BPMultiLevelCatalogueModel1st *model1 = BPValidateArrayObjAtIdx(self.arraySource, indexPath.section);
    BPMultiLevelCatalogueModel2nd *model2 = BPValidateArrayObjAtIdx(model1.array_1st, indexPath.row);
    [cell setModel:model2 indexPath:indexPath showAll:self.isShowAll];
    //根据当前数据，计算Cell的高度，注意+1是contentview和cell之间的分割线高度
//    NSInteger height = ceil([cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + kOnePixel + cell.tableView.contentSize.height);
    NSInteger height = ceil([cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + kOnePixel);
    return height;
    //return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
//        [cell setModel:model2 indexPath:indexPath showAll:self.isShowAll];
//    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    static BPIncludeTableSystemLayoutHeaderView *header;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        header = [[[NSBundle mainBundle] loadNibNamed:headerIdentifier owner:nil options:nil] firstObject];
    });
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    [header setModel:sectionModel section:section];
    NSInteger height = ceil([header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    return height;
}

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
