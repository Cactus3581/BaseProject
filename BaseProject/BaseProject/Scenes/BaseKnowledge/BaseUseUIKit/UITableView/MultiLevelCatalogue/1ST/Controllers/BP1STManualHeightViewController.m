//
//  BP1STManualHeightViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP1STManualHeightViewController.h"
#import "BP1STManualHeadCell.h"
#import "BP1STManualHeaderView.h"
#import "MJExtension.h"
#import "BP1STManualHeightHelper.h"
#import "BPMultiLevelCatalogueModel.h"
#import "NSObject+YYModel.h"
#import "BPMultiLevelCatalogueModelDataSource.h"

static NSInteger limitNumber = 2;

@interface BP1STManualHeightViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;//显示的数据
@property (nonatomic,strong) NSArray *arraySource;//显示的数据
@property (nonatomic,assign) CGFloat sectionHeight;//去除plain样式 头停留
@property (nonatomic,assign) BOOL showAll;
@property (nonatomic,strong) NSArray *wordMarkColorArray;//显示颜色的数据
@end

@implementation BP1STManualHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wordMarkColorArray = @[@"zoo"];
    [self handleData];
    [self configTableView];
}

- (void)configTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"BP1STManualHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BP1STManualHeaderView"];
    [self.tableView registerClass:[BP1STManualHeadCell class] forCellReuseIdentifier:@"BP1STManualHeadCell"];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.bounces = YES;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - TableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.showAll) {
        return BPValidateArray(self.arraySource).count;
    }else {
        return BPValidateArray(self.arraySource).count > limitNumber ?  limitNumber : BPValidateArray(self.arraySource).count;
    }
    return BPValidateArray(self.arraySource).count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BPMultiLevelCatalogueModel1st *model = BPValidateArrayObjAtIdx(self.arraySource, section);
    if (self.showAll) {
        return BPValidateArray(model.array_1st).count;
    }else {
        return BPValidateArray(model.array_1st).count > limitNumber ?  limitNumber : BPValidateArray(model.array_1st).count;
    }
    return BPValidateArray(model.array_1st).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BP1STManualHeadCell";
    BP1STManualHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    BPMultiLevelCatalogueModel1st *model1 = BPValidateArrayObjAtIdx(self.arraySource, indexPath.section);
    BPMultiLevelCatalogueModel2nd *model2 = BPValidateArrayObjAtIdx(model1.array_1st, indexPath.row);
    [cell setModel:model2 indexPath:indexPath showAll:YES];
    cell.wordMarkColorArray = self.wordMarkColorArray;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BP1STManualHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BP1STManualHeaderView"];
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    [header setModel:sectionModel section:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    self.sectionHeight = sectionModel.headerHeight;
    return sectionModel.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,indexPath.section);
    BPMultiLevelCatalogueModel2nd *model = BPValidateArrayObjAtIdx(sectionModel.array_1st, indexPath.row);
    return model.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = self.sectionHeight+1;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
}

- (void)handleData {
    BPMultiLevelCatalogueModel *model = [BPMultiLevelCatalogueModelDataSource handleData];
    [BP1STManualHeightHelper handleData:model successblock:^{
        self.arraySource = model.array;
        [self.tableView reloadData];
    }];
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
            NSLog(@"横屏");
        }else{
            NSLog(@"竖屏");
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        NSLog(@"动画播放完之后处理");
    }];
}

- (void)dealloc {
}

@end
