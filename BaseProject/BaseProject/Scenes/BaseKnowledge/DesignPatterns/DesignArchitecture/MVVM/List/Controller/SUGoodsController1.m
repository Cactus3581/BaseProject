//
//  SUGoodsController1.m
//  MHDevelopExample
//
//  Created by senba on 2017/6/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  MVVM Without RAC 开发模式的商品首页控制器 -- C

#import "SUGoodsController1.h"
#import "SUGoodsCell.h"
#import "FBKVOController.h"
#import "SUGoodsViewModel1.h"

@interface SUGoodsController1 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) SUGoodsViewModel1 *viewModel;
@property (nonatomic, strong) FBKVOController *KVOController;

@end


@implementation SUGoodsController1

- (void)viewDidLoad {
    [super viewDidLoad];
    SUGoodsViewModel1 *viewModel = [SUGoodsViewModel1 new];
    _viewModel = viewModel;
    
    [viewModel loadData:^(NSArray *array) {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [self setupSubViews];
    [self bindViewModel];
}

#pragma mark - BindModel
- (void)bindViewModel{
    _KVOController = [FBKVOController controllerWithObserver:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SUGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SUGoodsCell class])];
    SUGoodsItemViewModel *itemViewModel = self.viewModel.dataSource[indexPath.row];

    // 处理事件
    @weakify(self);
    // 头像
    cell.avatarClickedHandler = ^(SUGoodsCell *goodsCell) {
        @strongify(self);
        [self pushToPublicViewControllerWithTitle:itemViewModel];
    };
    
    // 回复
    cell.replyClickedHandler = ^(SUGoodsCell *goodsCell) {
        @strongify(self);
        [self pushToPublicViewControllerWithTitle:itemViewModel];
    };
    
    // 点赞
    cell.thumbClickedHandler = ^(SUGoodsCell *goodsCell) {
        @strongify(self);
        // 点赞
        [self.viewModel thumbGoodsWithGoodsItemViewModel:itemViewModel success:^(NSNumber * responseObject) {
            NSString *tips = (responseObject.boolValue)?@"收藏商品成功":@"取消收藏商品";
            // reload data
            [self.tableView reloadData];
        } failure:nil];
    };
    
    // config data ,PS：由于MVVM主要是View与数据之间的绑定，但是跟 setViewModel: 差不多
    cell.itemViewModel = itemViewModel;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 跳转到商品详请
    [self pushToPublicViewControllerWithTitle:nil];
}

#pragma mark - 辅助方法
// 跳转界面 这里只是一个跳转，实际情况，自行定夺
- (void)pushToPublicViewControllerWithTitle:(SUGoodsItemViewModel *)itemViewModel {

}

#pragma mark - 初始化子控件
- (void)setupSubViews {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView = tableView;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableHeaderView = [[UIView alloc]init];
    self.tableView.tableFooterView = [[UIView alloc]init];
    //self.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    //self.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    //warning: 注意不能是CGFLOAT_MIN
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [_tableView registerNib:[SUGoodsCell bp_loadNib] forCellReuseIdentifier:NSStringFromClass([SUGoodsCell class])];
}

@end
