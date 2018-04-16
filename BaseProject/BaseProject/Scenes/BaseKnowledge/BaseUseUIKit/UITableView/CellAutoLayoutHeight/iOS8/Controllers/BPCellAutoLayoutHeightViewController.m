//
//  BPCellAutoLayoutHeightViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCellAutoLayoutHeightViewController.h"
#import "BPCellAutoLayoutHeightTableViewCell.h"
#import "BPCellAutoLayoutHeightHeaderView.h"
#import "BPCellAutoLayoutHeightFooterView.h"
#import "Masonry.h"
#import "BPCellAutoLayoutHeightModel.h"

@interface BPCellAutoLayoutHeightViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;

@end

@implementation BPCellAutoLayoutHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTable];
}

- (void)configureTable {
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView reloadData];
}

//下划线 循环引用
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        _tableView.backgroundColor = kGreenColor;
        //_tableView.estimatedRowHeight = 44.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        //iOS11下不想使用Self-Sizing的话，可以通过以下方式关闭：（前言中提到的问题也是通过这种方式解决的）
        //_tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        //_tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerNib:[UINib nibWithNibName:@"BPCellAutoLayoutHeightHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BPCellAutoLayoutHeightHeaderView"];
        [_tableView registerNib:[UINib nibWithNibName:@"BPCellAutoLayoutHeightTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BPCellAutoLayoutHeightTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"BPCellAutoLayoutHeightFooterView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BPCellAutoLayoutHeightFooterView"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row+1)*10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPCellAutoLayoutHeightHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BPCellAutoLayoutHeightHeaderView"];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    BPCellAutoLayoutHeightFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BPCellAutoLayoutHeightFooterView"];
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPCellAutoLayoutHeightTableViewCell";
    BPCellAutoLayoutHeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BPCellAutoLayoutHeightModel *model = self.array[indexPath.row];
    [cell setModel:model indexPath:indexPath];
    return cell;
}

#pragma mark -懒加载
- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i<10; i++) {
            BPCellAutoLayoutHeightModel *model = [[BPCellAutoLayoutHeightModel alloc] init];
            model.headImage = @"";
            model.text = @"";
            model.photoImage = @"";
            [_array addObject:model];
        }
    }
    return _array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
