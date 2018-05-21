//
//  KSHeritageDictionaryListView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSHeritageDictionaryListView.h"
#import "KSHeritageDictionaryListTableViewCell.h"
#import "KSHeritageDictionaryMacro.h"

static NSString *kHeritageDictionaryList  = @"KSHeritageDictionaryList";
@interface KSHeritageDictionaryListView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation KSHeritageDictionaryListView

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
    [_tableView registerNib:[UINib nibWithNibName:@"KSHeritageDictionaryListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KSHeritageDictionaryListTableViewCell"];
    _tableView.backgroundColor = kWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 165.f;
    _tableView.estimatedRowHeight = 0.f;
    _tableView.estimatedSectionHeaderHeight = 0.f;
    _tableView.estimatedSectionFooterHeight = 0.f;
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
    static NSString *identifier = @"KSHeritageDictionaryListTableViewCell";
    KSHeritageDictionaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    KSWordBookAuthorityDictionaryThirdCategoryModel *thirdCategoryModel = self.array[indexPath.row];
    [cell setModel:thirdCategoryModel indexPath:indexPath];
    return cell;
}

@end
