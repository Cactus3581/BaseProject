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
    [self _setupSubViews];
    [self _bindViewModel];
}

#pragma mark - BindModel
- (void)_bindViewModel{
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
    /// 处理事件
    @weakify(self);
    /// 头像
    cell.avatarClickedHandler = ^(SUGoodsCell *goodsCell) {
        @strongify(self);
        SUGoodsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.row];
        [self _pushToPublicViewControllerWithTitle:viewModel];
    };
    /// 位置
    cell.locationClickedHandler = ^(SUGoodsCell *goodsCell) {
        @strongify(self);
        SUGoodsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.row];
        [self _pushToPublicViewControllerWithTitle:viewModel];
    };
    
    /// 回复
    cell.replyClickedHandler = ^(SUGoodsCell *goodsCell) {
        @strongify(self);
        SUGoodsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.row];
        [self _pushToPublicViewControllerWithTitle:viewModel];
    };
    
    /// 点赞
    cell.thumbClickedHandler = ^(SUGoodsCell *goodsCell) {
        @strongify(self);
        SUGoodsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.row];
        /// 点赞
        [self.viewModel thumbGoodsWithGoodsItemViewModel:viewModel success:^(NSNumber * responseObject) {
            NSString *tips = (responseObject.boolValue)?@"收藏商品成功":@"取消收藏商品";
            /// reload data
            [self.tableView reloadData];
        } failure:nil];
    };
    
    /// config data (PS：由于MVVM主要是View与数据之间的绑定，但是跟 setViewModel: 差不多啦)
//    [cell bindViewModel:object];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 由于使用系统的autoLayout来计算cell的高度，每次滚动时都要重新计算cell的布局以此来获得cell的高度 这样一来性能不好
    /// 所以笔者采用实现计算好的cell的高度
    return [self.viewModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 跳转到商品详请
    [self _pushToPublicViewControllerWithTitle:nil];
}

#pragma mark - 辅助方法
/// 跳转界面 这里只是一个跳转，实际情况，自行定夺
- (void)_pushToPublicViewControllerWithTitle:(SUGoodsItemViewModel *)itemViewModel {

}

#pragma mark - 初始化子控件
- (void)_setupSubViews {
    [self.tableView registerNib:[SUGoodsCell bp_loadNib] forCellReuseIdentifier:@""];
}

@end
