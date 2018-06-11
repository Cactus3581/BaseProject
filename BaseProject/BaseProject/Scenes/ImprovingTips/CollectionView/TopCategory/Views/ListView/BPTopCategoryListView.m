//
//  BPTopCategoryListView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryListView.h"
#import "BPTopCategoryListTableViewCell.h"
#import "BPTopCategoryMacro.h"

static NSString *identifier  = @"BPTopCategoryListTableViewCell";

@interface BPTopCategoryListView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation BPTopCategoryListView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configTableView];
}

- (void)setHeaderView:(UIView *)headerView {
    _headerView = headerView;
    self.tableView.tableHeaderView = headerView;
}

- (void)setArray:(NSArray *)array {
    _array = array;
    if (!_array.count) {
        //展示无数据页面
    }else {

    }
    [self.tableView reloadData];
}

- (void)configTableView {
    self.backgroundColor = kWhiteColor;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView = tableView;
    [_tableView registerNib:[UINib nibWithNibName:@"BPTopCategoryListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    _tableView.backgroundColor = kWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 165.f;
    _tableView.estimatedRowHeight = 165.f;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BPValidateArray(self.array).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPTopCategoryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//    BPTopCategoryThirdCategoryModel *thirdCategoryModel = self.array[indexPath.row];
//    [cell setModel:thirdCategoryModel indexPath:indexPath];
    return cell;
}

-  (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BPTopCategoryListTableViewCell *cell1 = (BPTopCategoryListTableViewCell *)cell;
    BPTopCategoryThirdCategoryModel *thirdCategoryModel = self.array[indexPath.row];
    [cell1 setModel:thirdCategoryModel indexPath:indexPath];
    if (indexPath.row == self.array.count - 1) {
//        cell1.hiddenLine = YES;
    }else {
//        cell1.hiddenLine = NO;
    }
}


@end
